using Aplicatie_Inventariere.Utility_Classes;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

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
            string pw = tbPassword.Text.ToString();

            if (!isValidEmail(email))
                return;

            bool ok = await AccountManager.GetInstance().Register(email, pw);
            if (ok)
                MessageBox.Show("Registered! You can now login!");
            else MessageBox.Show("Something went wrong! Try again later.");
        }

        private async void btnLogin_Click(object sender, EventArgs e)
        {
            string email = tbEmail.Text.ToString();
            string pw = tbPassword.Text.ToString();

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
                MessageBox.Show("Logged in with " + LocalDataStorage.email);
                this.Hide();
                MainScreen ms = new MainScreen();
                ms.ShowDialog();
                this.Close();
            }
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
    }
}
