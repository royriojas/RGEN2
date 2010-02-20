using System;
using System.Collections.Generic;
using System.Text;
using System.Security.Cryptography;

namespace RGen.Utiles 
{
    class Codificador
    {
        public static string CodificaEnMD5(string password)
        {
            MD5CryptoServiceProvider md5Hasher = new MD5CryptoServiceProvider();
            UTF8Encoding encoder = new UTF8Encoding();
            byte[] hashedBytes = md5Hasher.ComputeHash(encoder.GetBytes(password));

            return encoder.GetString(hashedBytes);
        }
        public static byte[] CodificaEnMD5ToBytes(string password)
        {
            MD5CryptoServiceProvider md5Hasher = new MD5CryptoServiceProvider();
            UTF8Encoding encoder = new UTF8Encoding();
            byte[] hashedBytes = md5Hasher.ComputeHash(encoder.GetBytes(password));

            return hashedBytes;

        }

    }
}
