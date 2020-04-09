namespace Aplicatie_Inventariere
{
    partial class QRcodes
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
            this.objectNameLabel = new System.Windows.Forms.Label();
            this.objectNameTextBox = new System.Windows.Forms.TextBox();
            this.roomLabel = new System.Windows.Forms.Label();
            this.roomTextBox = new System.Windows.Forms.TextBox();
            this.splitContainer1 = new System.Windows.Forms.SplitContainer();
            this.selectPrinterComboBox = new System.Windows.Forms.ComboBox();
            this.selectPrinterLabel = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.qrCodesListBox = new System.Windows.Forms.ListBox();
            this.createQrButton = new System.Windows.Forms.PictureBox();
            this.printBtn = new System.Windows.Forms.PictureBox();
            this.deleteBtn = new System.Windows.Forms.PictureBox();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer1)).BeginInit();
            this.splitContainer1.Panel1.SuspendLayout();
            this.splitContainer1.Panel2.SuspendLayout();
            this.splitContainer1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.createQrButton)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.printBtn)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.deleteBtn)).BeginInit();
            this.SuspendLayout();
            // 
            // objectNameLabel
            // 
            this.objectNameLabel.AutoSize = true;
            this.objectNameLabel.Location = new System.Drawing.Point(21, 18);
            this.objectNameLabel.Name = "objectNameLabel";
            this.objectNameLabel.Size = new System.Drawing.Size(67, 13);
            this.objectNameLabel.TabIndex = 0;
            this.objectNameLabel.Text = "Object name";
            // 
            // objectNameTextBox
            // 
            this.objectNameTextBox.Location = new System.Drawing.Point(94, 15);
            this.objectNameTextBox.Name = "objectNameTextBox";
            this.objectNameTextBox.Size = new System.Drawing.Size(100, 20);
            this.objectNameTextBox.TabIndex = 1;
            // 
            // roomLabel
            // 
            this.roomLabel.AutoSize = true;
            this.roomLabel.Location = new System.Drawing.Point(21, 50);
            this.roomLabel.Name = "roomLabel";
            this.roomLabel.Size = new System.Drawing.Size(35, 13);
            this.roomLabel.TabIndex = 2;
            this.roomLabel.Text = "Room";
            // 
            // roomTextBox
            // 
            this.roomTextBox.Location = new System.Drawing.Point(94, 47);
            this.roomTextBox.Name = "roomTextBox";
            this.roomTextBox.Size = new System.Drawing.Size(100, 20);
            this.roomTextBox.TabIndex = 3;
            // 
            // splitContainer1
            // 
            this.splitContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.splitContainer1.Location = new System.Drawing.Point(0, 0);
            this.splitContainer1.Name = "splitContainer1";
            // 
            // splitContainer1.Panel1
            // 
            this.splitContainer1.Panel1.Controls.Add(this.objectNameLabel);
            this.splitContainer1.Panel1.Controls.Add(this.createQrButton);
            this.splitContainer1.Panel1.Controls.Add(this.objectNameTextBox);
            this.splitContainer1.Panel1.Controls.Add(this.roomTextBox);
            this.splitContainer1.Panel1.Controls.Add(this.roomLabel);
            // 
            // splitContainer1.Panel2
            // 
            this.splitContainer1.Panel2.Controls.Add(this.deleteBtn);
            this.splitContainer1.Panel2.Controls.Add(this.printBtn);
            this.splitContainer1.Panel2.Controls.Add(this.selectPrinterComboBox);
            this.splitContainer1.Panel2.Controls.Add(this.selectPrinterLabel);
            this.splitContainer1.Panel2.Controls.Add(this.label1);
            this.splitContainer1.Panel2.Controls.Add(this.qrCodesListBox);
            this.splitContainer1.Size = new System.Drawing.Size(1173, 450);
            this.splitContainer1.SplitterDistance = 399;
            this.splitContainer1.TabIndex = 5;
            // 
            // selectPrinterComboBox
            // 
            this.selectPrinterComboBox.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.selectPrinterComboBox.FormattingEnabled = true;
            this.selectPrinterComboBox.Location = new System.Drawing.Point(644, 1);
            this.selectPrinterComboBox.Name = "selectPrinterComboBox";
            this.selectPrinterComboBox.Size = new System.Drawing.Size(121, 21);
            this.selectPrinterComboBox.TabIndex = 1;
            // 
            // selectPrinterLabel
            // 
            this.selectPrinterLabel.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.selectPrinterLabel.AutoSize = true;
            this.selectPrinterLabel.Location = new System.Drawing.Point(569, 4);
            this.selectPrinterLabel.Name = "selectPrinterLabel";
            this.selectPrinterLabel.Size = new System.Drawing.Size(69, 13);
            this.selectPrinterLabel.TabIndex = 5;
            this.selectPrinterLabel.Text = "Select printer";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(4, 4);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(101, 13);
            this.label1.TabIndex = 1;
            this.label1.Text = "Qr code print queue";
            // 
            // qrCodesListBox
            // 
            this.qrCodesListBox.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.qrCodesListBox.FormattingEnabled = true;
            this.qrCodesListBox.Location = new System.Drawing.Point(3, 30);
            this.qrCodesListBox.Name = "qrCodesListBox";
            this.qrCodesListBox.Size = new System.Drawing.Size(767, 420);
            this.qrCodesListBox.TabIndex = 0;
            // 
            // createQrButton
            // 
            this.createQrButton.Image = global::Aplicatie_Inventariere.Properties.Resources.butonAdd;
            this.createQrButton.Location = new System.Drawing.Point(94, 73);
            this.createQrButton.Name = "createQrButton";
            this.createQrButton.Size = new System.Drawing.Size(100, 50);
            this.createQrButton.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.createQrButton.TabIndex = 4;
            this.createQrButton.TabStop = false;
            this.createQrButton.Click += new System.EventHandler(this.createQrBtn_Click);
            // 
            // printBtn
            // 
            this.printBtn.Anchor = System.Windows.Forms.AnchorStyles.Top;
            this.printBtn.Image = global::Aplicatie_Inventariere.Properties.Resources.butonPrint;
            this.printBtn.Location = new System.Drawing.Point(223, 0);
            this.printBtn.Name = "printBtn";
            this.printBtn.Size = new System.Drawing.Size(125, 31);
            this.printBtn.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.printBtn.TabIndex = 5;
            this.printBtn.TabStop = false;
            this.printBtn.Click += new System.EventHandler(this.printBtn_Click);
            // 
            // deleteBtn
            // 
            this.deleteBtn.Anchor = System.Windows.Forms.AnchorStyles.Top;
            this.deleteBtn.Image = global::Aplicatie_Inventariere.Properties.Resources.butonDelete;
            this.deleteBtn.Location = new System.Drawing.Point(354, 0);
            this.deleteBtn.Name = "deleteBtn";
            this.deleteBtn.Size = new System.Drawing.Size(125, 31);
            this.deleteBtn.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.deleteBtn.TabIndex = 6;
            this.deleteBtn.TabStop = false;
            this.deleteBtn.Click += new System.EventHandler(this.deleteBtn_Click);
            // 
            // QRcodes
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1173, 450);
            this.Controls.Add(this.splitContainer1);
            this.MinimumSize = new System.Drawing.Size(800, 400);
            this.Name = "QRcodes";
            this.Text = "QRcodes";
            this.FormClosed += new System.Windows.Forms.FormClosedEventHandler(this.QRcodes_FormClosed);
            this.Load += new System.EventHandler(this.QRcodes_Load);
            this.splitContainer1.Panel1.ResumeLayout(false);
            this.splitContainer1.Panel1.PerformLayout();
            this.splitContainer1.Panel2.ResumeLayout(false);
            this.splitContainer1.Panel2.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer1)).EndInit();
            this.splitContainer1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.createQrButton)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.printBtn)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.deleteBtn)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Label objectNameLabel;
        private System.Windows.Forms.TextBox objectNameTextBox;
        private System.Windows.Forms.Label roomLabel;
        private System.Windows.Forms.TextBox roomTextBox;
        private System.Windows.Forms.PictureBox createQrButton;
        private System.Windows.Forms.SplitContainer splitContainer1;
        private System.Windows.Forms.ListBox qrCodesListBox;
        private System.Windows.Forms.Label selectPrinterLabel;
        private System.Windows.Forms.ComboBox selectPrinterComboBox;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.PictureBox printBtn;
        private System.Windows.Forms.PictureBox deleteBtn;
    }
}