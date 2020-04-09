namespace Aplicatie_Inventariere
{
    partial class MainScreen
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.btnQRCodes = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // btnQRCodes
            // 
            this.btnQRCodes.Location = new System.Drawing.Point(12, 12);
            this.btnQRCodes.Name = "btnQRCodes";
            this.btnQRCodes.Size = new System.Drawing.Size(75, 23);
            this.btnQRCodes.TabIndex = 0;
            this.btnQRCodes.Text = "QR Codes";
            this.btnQRCodes.UseVisualStyleBackColor = true;
            this.btnQRCodes.Click += new System.EventHandler(this.btnQRCodes_Click);
            // 
            // MainScreen
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.btnQRCodes);
            this.Name = "MainScreen";
            this.Text = "MainScreen";
            this.Load += new System.EventHandler(this.MainScreen_Load);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button btnQRCodes;
    }
}