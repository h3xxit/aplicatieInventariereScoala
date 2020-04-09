using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using ZXing.Common;
using ZXing;
using ZXing.QrCode;
using System.Drawing.Printing;
using FireSharp.Config;
using FireSharp.Response;
using FireSharp.Interfaces;
using Aplicatie_Inventariere.DTO;

namespace Aplicatie_Inventariere
{
    public partial class QRcodes : Form
    {
        class QRCode
        {
            private string uuid, name, room;
            public string UUID
            {
                get { return uuid; }
                set { uuid = value; }
            }
            public string Name
            {
                get { return name; }
                set { name = value; }
            }
            public string Room
            {
                get { return room; }
                set { room = value; }
            }
            public string ListDisplayName
            {
                get { return name + ", " + room; }
            }

            public QRCode(string uuid, string name, string room)
            {
                this.uuid = uuid;
                this.name = name;
                this.room = room;
            }
        }
        BindingList<QRCode> allPendingCodes;
        QrCodeEncodingOptions options = new QrCodeEncodingOptions();
        List<Bitmap> qrResult;
        List<QRCode> textResult;
        string readableId;
        int qrCodeSize = 200;
        IFirebaseConfig firebaseConfig = new FirebaseConfig()
        {
            AuthSecret = "MgtFwqPvHE1nzOCE5gRXtyuq5ehLUvo5vvewYps0",
            BasePath = "https://inventarierescoala.firebaseio.com/"
        };

        IFirebaseClient client;

        public QRcodes()
        {
            InitializeComponent();
            allPendingCodes = new BindingList<QRCode>();
            foreach (string printerName in PrinterSettings.InstalledPrinters)
            {
                selectPrinterComboBox.Items.Add(printerName);
            }
            qrCodesListBox.DataSource = allPendingCodes;
            qrCodesListBox.DisplayMember = "ListDisplayName";
            qrCodesListBox.ValueMember = "UUID";
            qrCodesListBox.SelectionMode = SelectionMode.MultiExtended;
            //TODO: init allPendingCodes from database
        }

        private void QRcodes_Load(object sender, EventArgs e)
        {
            try
            {
                client = new FireSharp.FirebaseClient(firebaseConfig);
            }
            catch
            {
                MessageBox.Show("Unexpected internet error, try again");
            }
        }

        private void createQrBtn_Click(object sender, EventArgs e)
        {
            string name = objectNameTextBox.Text;
            string room = roomTextBox.Text;
            string UUID = Guid.NewGuid().ToString("N");
            allPendingCodes.Add(new QRCode(UUID, name, room));
            string path = @"Objects/" + LocalDataStorage.email.Replace('.', ',') + "/" + UUID;
            client.Set(path, new ObjectDto(name, room));
        }

        private void Pd_PrintPage(object sender, PrintPageEventArgs e)
        {
            for(int i = 0; i<qrResult.Count; ++i)
            {
                Point textLoc = new Point(10 + (qrCodeSize * (i % 4)), 10 + (qrCodeSize * (i / 4)));
                Point qrLoc = new Point(10 + (qrCodeSize * (i % 4)), 30 + (qrCodeSize * (i / 4)));
                e.Graphics.DrawString(textResult[i].ListDisplayName, Font, Brushes.Black, textLoc);
                e.Graphics.DrawImage(qrResult[i], qrLoc);
            }
        }

        private void printBtn_Click(object sender, EventArgs e)
        {
            var allItems = qrCodesListBox.SelectedItems.Cast<QRCode>();
            if (allItems.Count() == 0)
            {
                MessageBox.Show("Select what qr codes you want to print");
                return;
            }
            if(allItems.Count() > 20)
            {
                MessageBox.Show("Cannot print more than 20 qr codes on a page");
                return;
            }
            options = new QrCodeEncodingOptions
            {
                DisableECI = true,
                CharacterSet = "UTF-8",
                Width = qrCodeSize,
                Height = qrCodeSize,
            };
            var writer = new BarcodeWriter();
            writer.Format = BarcodeFormat.QR_CODE;
            writer.Options = options;
            qrResult = new List<Bitmap>();
            foreach(var item in allItems)
            {
                qrResult.Add(new Bitmap(writer.Write("https://inventarscoalaweb.herokuapp.com/" + item.UUID)));
            }
            textResult = allItems.ToList();

            if (selectPrinterComboBox.SelectedItem == null)
            {
                MessageBox.Show("please select a printer");
                return;
            }
            PrintDocument pd = new PrintDocument();
            pd.PrintPage += Pd_PrintPage;
            pd.PrinterSettings.PrinterName = (string)selectPrinterComboBox.SelectedItem;
            //PrintPreviewDialog pdial = new PrintPreviewDialog();
            //pdial.Document = pd;
            //pdial.ShowDialog();
            pd.Print();
            if(MessageBox.Show("Would you like to delete these items from the printing queue", "Delete items", MessageBoxButtons.YesNo) == DialogResult.Yes)
            {
                deleteItems(allItems);
            }
        }

        private void QRcodes_FormClosed(object sender, FormClosedEventArgs e)
        {

        }

        private void deleteBtn_Click(object sender, EventArgs e)
        {
            deleteItems(qrCodesListBox.SelectedItems.Cast<QRCode>());
        }

        private void deleteItems(IEnumerable<QRCode> qrCodesToDelete)
        {
            List<QRCode> listToDelete = new List<QRCode>();
            foreach (var item in qrCodesToDelete)
            {
                listToDelete.Add(item);
            }
            foreach(QRCode code in listToDelete)
            {
                allPendingCodes.Remove(code);
            }
        }
    }
}
