namespace FP1
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
            this.DGVNeighborhoods = new System.Windows.Forms.DataGridView();
            this.DGVSmartHomes = new System.Windows.Forms.DataGridView();
            this.SaveButton = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.DGVNeighborhoods)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.DGVSmartHomes)).BeginInit();
            this.SuspendLayout();
            // 
            // DGVNeighborhoods
            // 
            this.DGVNeighborhoods.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.DGVNeighborhoods.Location = new System.Drawing.Point(38, 42);
            this.DGVNeighborhoods.Name = "DGVNeighborhoods";
            this.DGVNeighborhoods.RowHeadersWidth = 51;
            this.DGVNeighborhoods.RowTemplate.Height = 24;
            this.DGVNeighborhoods.Size = new System.Drawing.Size(750, 150);
            this.DGVNeighborhoods.TabIndex = 0;
            // 
            // DGVSmartHomes
            // 
            this.DGVSmartHomes.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.DGVSmartHomes.Location = new System.Drawing.Point(38, 252);
            this.DGVSmartHomes.Name = "DGVSmartHomes";
            this.DGVSmartHomes.RowHeadersWidth = 51;
            this.DGVSmartHomes.RowTemplate.Height = 24;
            this.DGVSmartHomes.Size = new System.Drawing.Size(750, 150);
            this.DGVSmartHomes.TabIndex = 1;
            // 
            // SaveButton
            // 
            this.SaveButton.Location = new System.Drawing.Point(263, 418);
            this.SaveButton.Name = "SaveButton";
            this.SaveButton.Size = new System.Drawing.Size(284, 40);
            this.SaveButton.TabIndex = 2;
            this.SaveButton.Text = "Save Changes";
            this.SaveButton.UseVisualStyleBackColor = true;
            this.SaveButton.Click += new System.EventHandler(this.SaveButton_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(35, 9);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(101, 16);
            this.label1.TabIndex = 3;
            this.label1.Text = "Neighborhoods";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(35, 223);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(89, 16);
            this.label2.TabIndex = 4;
            this.label2.Text = "Smart Homes";
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(224)))), ((int)(((byte)(224)))));
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.SaveButton);
            this.Controls.Add(this.DGVSmartHomes);
            this.Controls.Add(this.DGVNeighborhoods);
            this.Name = "Form1";
            this.Text = "Form1";
            ((System.ComponentModel.ISupportInitialize)(this.DGVNeighborhoods)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.DGVSmartHomes)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView DGVNeighborhoods;
        private System.Windows.Forms.DataGridView DGVSmartHomes;
        private System.Windows.Forms.Button SaveButton;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
    }
}

