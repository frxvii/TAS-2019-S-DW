using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public static class TexGenerator
{
    public static Texture2D TexFromColorMap(Color[] colorMap, int width, int height)
    {
        Texture2D texture = new Texture2D(width, height);

        // clear the seam of textures
        texture.filterMode = FilterMode.Point;
        texture.wrapMode = TextureWrapMode.Clamp;

        texture.SetPixels (colorMap);
        texture.Apply();
        return texture;
    }

    public static Texture2D TexFromHeightMap(float[,] heightMap)
    {
        int width = heightMap.GetLength(0);
        int height = heightMap.GetLength(1);

        

        Color[] colorMap = new Color[width * height];
        for (int y = 0; y < height; y++)
        {
            for (int x = 0; x < width; x++)
            {
                colorMap [y * width + x] = Color.Lerp(Color.black, Color.white, heightMap[x, y]);
                // Convert the noiseMap 2D array to a 1D color array;
            }
        }
        return TexFromColorMap(colorMap, width, height);
    }
}
