namespace FP3
{
    partial class Form1
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
            this.ComboBoxComenzi = new System.Windows.Forms.ComboBox();
            this.DGVPreparateComenzi = new System.Windows.Forms.DataGridView();
            this.SaveButton = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.DGVPreparateComenzi)).BeginInit();
            this.SuspendLayout();
            // 
            // ComboBoxComenzi
            // 
            this.ComboBoxComenzi.FormattingEnabled = true;
            this.ComboBoxComenzi.Location = new System.Drawing.Point(12, 86);
            this.ComboBoxComenzi.Name = "ComboBoxComenzi";
            this.ComboBoxComenzi.Size = new System.Drawing.Size(181, 24);
            this.ComboBoxComenzi.TabIndex = 0;
            // 
            // DGVPreparateComenzi
            // 
            this.DGVPreparateComenzi.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.DGVPreparateComenzi.Location = new System.Drawing.Point(232, 86);
            this.DGVPreparateComenzi.Name = "DGVPreparateComenzi";
            this.DGVPreparateComenzi.RowHeadersWidth = 51;
            this.DGVPreparateComenzi.RowTemplate.Height = 24;
            this.DGVPreparateComenzi.Size = new System.Drawing.Size(533, 173);
            this.DGVPreparateComenzi.TabIndex = 1;
            // 
            // SaveButton
            // 
            this.SaveButton.Location = new System.Drawing.Point(12, 301);
            this.SaveButton.Name = "SaveButton";
            this.SaveButton.Size = new System.Drawing.Size(753, 23);
            this.SaveButton.TabIndex = 2;
            this.SaveButton.Text = "Claudia Coste";
            this.SaveButton.UseVisualStyleBackColor = true;
            this.SaveButton.Click += new System.EventHandler(this.SaveButton_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.SaveButton);
            this.Controls.Add(this.DGVPreparateComenzi);
            this.Controls.Add(this.ComboBoxComenzi);
            this.Name = "Form1";
            this.Text = "Form1";
            ((System.ComponentModel.ISupportInitialize)(this.DGVPreparateComenzi)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.ComboBox ComboBoxComenzi;
        private System.Windows.Forms.DataGridView DGVPreparateComenzi;
        private System.Windows.Forms.Button SaveButton;
    }
}

