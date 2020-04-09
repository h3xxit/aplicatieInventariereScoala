using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Firebase.Auth;
using Firebase.Database;

namespace Aplicatie_Inventariere.Utility_Classes
{
    class AccountManager
    {
        private static AccountManager mInstance;
        public static FirebaseAuthProvider mAuthProvider = new FirebaseAuthProvider(new FirebaseConfig("AIzaSyBJEEW6b1RStTBt8tbcs9WAmX4O418SBf0"));
        public FirebaseAuthLink mAuthLink;
        public static bool IsSignOut = false;

        public static AccountManager GetInstance()
        {
            if (mInstance == null)
                mInstance = new AccountManager();

            return mInstance;
        }

        public async Task<bool> Refreshable()
        {
            try
            {
                var auth = new FirebaseAuth();
                auth.FirebaseToken = LocalDataStorage.token;
                auth.RefreshToken = LocalDataStorage.refresh_token;

                mAuthLink = await mAuthProvider.RefreshAuthAsync(auth);
                mAuthLink = await mAuthLink.GetFreshAuthAsync();
                mAuthLink.FirebaseAuthRefreshed += AuthLink_FirebaseAuthRefreshedAsync;

                await mAuthLink.RefreshUserDetails();

                if (string.IsNullOrEmpty(mAuthLink.FirebaseToken))
                    return false;

                if (mAuthLink.User == null)
                    return false;

                IsSignOut = false;

                return true;
            }
            catch (Exception e)
            {
                return false;
            }
        }


        public async Task<bool> SignIn(string email, string password)
        {
            try
            {
                mAuthLink = await mAuthProvider.SignInWithEmailAndPasswordAsync(email, password);
                var firebase = new FirebaseClient(
                      "https://inventarierescoala.firebaseio.com/",
                      new FirebaseOptions
                      {
                          AuthTokenAsyncFactory = () => Task.FromResult(mAuthLink.FirebaseToken)

                      });

                LocalDataStorage.email = mAuthLink.User.Email;
                LocalDataStorage.token = mAuthLink.FirebaseToken;
                LocalDataStorage.refresh_token = mAuthLink.RefreshToken;
                IsSignOut = false;

                await mAuthLink.RefreshUserDetails();
                mAuthLink.FirebaseAuthRefreshed += AuthLink_FirebaseAuthRefreshedAsync;

                return true;
            }
            catch
            {
                return false;
            }
        }

        public bool SignOut()
        {
            try
            {
                LocalDataStorage.email = mAuthLink.User.Email;
                LocalDataStorage.token = "";
                LocalDataStorage.refresh_token = "";
                IsSignOut = true;
                return true;
            }
            catch
            {
                return false;
            }
        }


        private async void AuthLink_FirebaseAuthRefreshedAsync(object sender, FirebaseAuthEventArgs e)
        {
            LocalDataStorage.token = e.FirebaseAuth.FirebaseToken;
            LocalDataStorage.refresh_token = e.FirebaseAuth.RefreshToken;
            await mAuthLink.RefreshUserDetails();
            IsSignOut = !mAuthLink.IsExpired();
        }

        public async Task<bool> Register(string email, string password)
        {
            try
            {
                mAuthLink = await mAuthProvider.CreateUserWithEmailAndPasswordAsync(email, password);
                var firebase = new FirebaseClient(
                      "https://inventarierescoala.firebaseio.com/",
                      new FirebaseOptions
                      {
                          AuthTokenAsyncFactory = () => Task.FromResult(mAuthLink.FirebaseToken)
                      });

                
                return true;
            }
            catch
            {
                return false;
            }
        }

        public async Task<bool> sendPasswordResetEmail(string email)
        {

            try
            {
                await mAuthProvider.SendPasswordResetEmailAsync(email);
                return true;
            }
            catch
            {
                return false;
            }

        }
    }
}
