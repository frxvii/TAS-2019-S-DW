using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Noise : MonoBehaviour
{
    public enum  NormalizeMode{Local, Global};

    // Generate a noisemap using a 2D array
    // lacunarity controls increase in frequecey of octaves
    // different octaves can persent large mountains, boulders and rocks
    // persistance controls decrease in amplitude of octaves
    // seed is the index of a random map, if you want to the same map, use the same seed
    public static float[,] GenerateNoiseMap(int mapW, int mapH, int seed, float scale , int octaves, 
        float persistance, float lacunarity, Vector2 offset, NormalizeMode normalizeMode)
    {
        float[,] noiseMap = new float[mapW, mapH];

        System.Random prng = new System.Random(seed);
        Vector2[] octaveOffsets = new Vector2[octaves];

        float maxPossibleHeight = 0;
        float amplitude = 1;
        float frequecey = 1; // the higher the frequecey, the further apart the sample points will be
        

        for (int i = 0; i < octaves; i++)
        {
            float offsetX = prng.Next(-100000, 100000) + offset.x;
            float offsetY = prng.Next(-100000, 100000) - offset.y;
            octaveOffsets[i] = new Vector2(offsetX, offsetY);

            maxPossibleHeight += amplitude;
            amplitude *= persistance;
            // get maximum possible height value
        }

        if (scale <=0)
        {
            scale = 0.00011f;
        }

        float maxLocalNoiseHeight = float.MinValue;
        float minLocalNoiseHeight = float.MaxValue;
        
        // make the NoiseScale to zoom from the center
        float halfWidth = mapW / 2f; 
        float halfHeight = mapH / 2f;

        for (int y = 0; y < mapH; y++)
        {
            for (int x = 0; x < mapW; x++)
            {
                amplitude = 1;
                frequecey = 1; // the higher the frequecey, the further apart the sample points will be
                float noiseHeight = 0;
                for (int i = 0; i < octaves; i++)
                {
                    float tempX = (x - halfWidth + octaveOffsets[i].x) / scale * frequecey;
                    float tempY = (y - halfHeight + octaveOffsets[i].y) / scale * frequecey;

                    float perlinValue = Mathf.PerlinNoise(tempX, tempY) * 2 -1; 
                    // the result of Mathf.PerlinNoise is in the range 0-1, *2 -1 makes the result from -1 to 1, so the noise height would decrease
                    
                    noiseHeight += perlinValue * amplitude; // increase noiseheight

                    amplitude *= persistance;
                    frequecey *= lacunarity;
                }

                // normalize the value 
                if (noiseHeight > maxLocalNoiseHeight)
                {
                    maxLocalNoiseHeight = noiseHeight;
                }
                else if(noiseHeight < minLocalNoiseHeight)
                {
                    minLocalNoiseHeight = noiseHeight;
                }
                noiseMap[x, y] = noiseHeight;
                
            }
        }
        for (int y = 0; y < mapH; y++)
        {
            for (int x = 0; x < mapW; x++)
            {
                if (normalizeMode == NormalizeMode.Local)
                {
                    noiseMap[x, y] = Mathf.InverseLerp(minLocalNoiseHeight, maxLocalNoiseHeight, noiseMap[x, y]); // .InverseLerp returns 0-1
                }
                else
                {
                    // reverse the perlinValue
                    // noise map values are in fact never going to come anywhere close to the max possible value
                    float normalizeHeight = (noiseMap[x, y] + 1) / (maxPossibleHeight * 1.1f); 
                    noiseMap [x, y] = Mathf.Clamp(normalizeHeight, 0, int.MaxValue);
                }
                
            }
        }
        
        
        return noiseMap;
    }
}
