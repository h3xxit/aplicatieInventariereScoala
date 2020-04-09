using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

using Google.Apis.Auth.OAuth2;
using Firebase;
using Firebase.Auth;
using Firebase.Database;

namespace Aplicatie_Inventariere
{

    public partial class Register : Form
    {
        public Register()
        {
            InitializeComponent();
        }

        private void Register_Load(object sender, EventArgs e)
        {

        }
        
        

        private async void btnRegister_Click(object sender, EventArgs e)
        {

            string email = tbEmail.Text.ToString();
            string pw = tbParola.Text.ToString();

            if (!isValidEmail(email))
                return;
            
            bool ok = await AccountManager.GetInstance().Register(email, pw);
            if (ok)
                MessageBox.Show("Registered! You can now login!");
            else MessageBox.Show("Something went wrong! Try again later.");
        }

        bool isValidEmail(string email)
        {
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == email;
            }
            catch
            {
                MessageBox.Show("Email address is not valid!");
                return false;
            }
        }

        private async void btnLogin_ClickAsync(object sender, EventArgs e)
        {
            string email = tbEmail.Text.ToString();
            string pw = tbParola.Text.ToString();

            if (!isValidEmail(email))
                return;
            bool ok = await AccountManager.GetInstance().SignIn(email, pw);
            if (ok == false)
            {
                MessageBox.Show("Something went wrong! Verify your email & password and try again later!");
                return;
            }
            else
            {
                MessageBox.Show("Logged in!");
            }


        }
        /*
        public async Task<bool> SignIn(string email, string password)
        {

            FirebaseAuthLink mAuthLink;
            try
            {
                FirebaseAuthProvider mAuthProvider = new FirebaseAuthProvider(new FirebaseConfig("AIzaSyBJEEW6b1RStTBt8tbcs9WAmX4O418SBf0"));
                
                mAuthLink = await mAuthProvider.SignInWithEmailAndPasswordAsync(email, password);
                var firebase = new FirebaseClient(
                      "https://inventarierescoala.firebaseio.com/",
                      new FirebaseOptions
                      {
                          AuthTokenAsyncFactory = () => Task.FromResult(mAuthLink.FirebaseToken)

                      });

                // Process user info from mAuthLink
                string email_txt, token_txt;
                email_txt = mAuthLink.User.Email;
                token_txt = mAuthLink.FirebaseToken;
                return true;
            }
            catch (Exception e)
            {
                MessageBox.Show(e.ToString());
                return false;
            }
        }

        public async Task<bool> registerEmailAndPassword(string email, string password)
        {
            FirebaseAuthLink mAuthLink;
            try
            {
                FirebaseAuthProvider mAuthProvider = new FirebaseAuthProvider(new FirebaseConfig("AIzaSyBJEEW6b1RStTBt8tbcs9WAmX4O418SBf0"));

                mAuthLink = await mAuthProvider.CreateUserWithEmailAndPasswordAsync(email, password);
                var firebase = new FirebaseClient(
                      "https://inventarierescoala.firebaseio.com/",
                      new FirebaseOptions
                      {
                          AuthTokenAsyncFactory = () => Task.FromResult(mAuthLink.FirebaseToken)

                      });

                // Process user info from mAuthLink
                string email_txt, token_txt;
                email_txt = mAuthLink.User.Email;
                token_txt = mAuthLink.FirebaseToken;
                return true;
            }
            catch
            {
                return false;
            }
        }

        public async Task<bool> sendEmail(string email)
        {
            try
            {
                FirebaseAuthLink mAuthLink;
                FirebaseAuthProvider mAuthProvider = new FirebaseAuthProvider(new FirebaseConfig("AIzaSyBJEEW6b1RStTBt8tbcs9WAmX4O418SBf0"));

                await mAuthProvider.SendPasswordResetEmailAsync("mirela.magdalena.mm@gmail.com");
                return true;
            }
            catch
            {
                return false;
            }
        }
        */
    }
}
