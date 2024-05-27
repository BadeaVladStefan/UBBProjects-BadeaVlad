namespace FP4
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
            this.DGVDevelopers = new System.Windows.Forms.DataGridView();
            this.DGVTasks = new System.Windows.Forms.DataGridView();
            this.SaveButton = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.DGVDevelopers)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.DGVTasks)).BeginInit();
            this.SuspendLayout();
            // 
            // DGVDevelopers
            // 
            this.DGVDevelopers.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.DGVDevelopers.Location = new System.Drawing.Point(12, 34);
            this.DGVDevelopers.Name = "DGVDevelopers";
            this.DGVDevelopers.RowHeadersWidth = 51;
            this.DGVDevelopers.RowTemplate.Height = 24;
            this.DGVDevelopers.Size = new System.Drawing.Size(776, 150);
            this.DGVDevelopers.TabIndex = 0;
            // 
            // DGVTasks
            // 
            this.DGVTasks.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.DGVTasks.Location = new System.Drawing.Point(12, 219);
            this.DGVTasks.Name = "DGVTasks";
            this.DGVTasks.RowHeadersWidth = 51;
            this.DGVTasks.RowTemplate.Height = 24;
            this.DGVTasks.Size = new System.Drawing.Size(776, 150);
            this.DGVTasks.TabIndex = 1;
            // 
            // SaveButton
            // 
            this.SaveButton.Location = new System.Drawing.Point(21, 392);
            this.SaveButton.Name = "SaveButton";
            this.SaveButton.Size = new System.Drawing.Size(767, 23);
            this.SaveButton.TabIndex = 2;
            this.SaveButton.Text = "Save Changes";
            this.SaveButton.UseVisualStyleBackColor = true;
            this.SaveButton.Click += new System.EventHandler(this.SaveButton_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(9, 9);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(78, 16);
            this.label1.TabIndex = 3;
            this.label1.Text = "Developers";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(9, 200);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(45, 16);
            this.label2.TabIndex = 4;
            this.label2.Text = "Tasks";
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.SaveButton);
            this.Controls.Add(this.DGVTasks);
            this.Controls.Add(this.DGVDevelopers);
            this.Name = "Form1";
            this.Text = "Form1";
            ((System.ComponentModel.ISupportInitialize)(this.DGVDevelopers)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.DGVTasks)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView DGVDevelopers;
        private System.Windows.Forms.DataGridView DGVTasks;
        private System.Windows.Forms.Button SaveButton;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
    }
}

