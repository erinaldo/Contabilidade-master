﻿namespace Apresentacao
{
    partial class frmCadastrarItem
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
            this.cboCategoriaCadastrar = new MetroFramework.Controls.MetroComboBox();
            this.metroLabel3 = new MetroFramework.Controls.MetroLabel();
            this.txtQtdeCadastrar = new MetroFramework.Controls.MetroTextBox();
            this.metroLabel4 = new MetroFramework.Controls.MetroLabel();
            this.dtEntradaCadastrar = new MetroFramework.Controls.MetroDateTime();
            this.metroLabel1 = new MetroFramework.Controls.MetroLabel();
            this.metroLabel2 = new MetroFramework.Controls.MetroLabel();
            this.metroLabel5 = new MetroFramework.Controls.MetroLabel();
            this.btnSalvar = new MetroFramework.Controls.MetroButton();
            this.btnCancelar = new MetroFramework.Controls.MetroButton();
            this.btnLimpar = new MetroFramework.Controls.MetroButton();
            this.txtDescricaoCadastrar = new MetroFramework.Controls.MetroTextBox();
            this.txtPrecoCadastrar = new System.Windows.Forms.MaskedTextBox();
            this.metroLabel6 = new MetroFramework.Controls.MetroLabel();
            this.cboFornecedorCadastrarItem = new MetroFramework.Controls.MetroComboBox();
            this.SuspendLayout();
            // 
            // cboCategoriaCadastrar
            // 
            this.cboCategoriaCadastrar.FormattingEnabled = true;
            this.cboCategoriaCadastrar.ItemHeight = 23;
            this.cboCategoriaCadastrar.Location = new System.Drawing.Point(25, 195);
            this.cboCategoriaCadastrar.Name = "cboCategoriaCadastrar";
            this.cboCategoriaCadastrar.Size = new System.Drawing.Size(226, 29);
            this.cboCategoriaCadastrar.TabIndex = 2;
            this.cboCategoriaCadastrar.UseSelectable = true;
            // 
            // metroLabel3
            // 
            this.metroLabel3.AutoSize = true;
            this.metroLabel3.Location = new System.Drawing.Point(261, 119);
            this.metroLabel3.Name = "metroLabel3";
            this.metroLabel3.Size = new System.Drawing.Size(43, 19);
            this.metroLabel3.TabIndex = 4;
            this.metroLabel3.Text = "Preço";
            // 
            // txtQtdeCadastrar
            // 
            this.txtQtdeCadastrar.Lines = new string[0];
            this.txtQtdeCadastrar.Location = new System.Drawing.Point(261, 195);
            this.txtQtdeCadastrar.MaxLength = 32767;
            this.txtQtdeCadastrar.Multiline = true;
            this.txtQtdeCadastrar.Name = "txtQtdeCadastrar";
            this.txtQtdeCadastrar.PasswordChar = '\0';
            this.txtQtdeCadastrar.ScrollBars = System.Windows.Forms.ScrollBars.None;
            this.txtQtdeCadastrar.SelectedText = "";
            this.txtQtdeCadastrar.Size = new System.Drawing.Size(99, 29);
            this.txtQtdeCadastrar.TabIndex = 7;
            this.txtQtdeCadastrar.UseSelectable = true;
            // 
            // metroLabel4
            // 
            this.metroLabel4.AutoSize = true;
            this.metroLabel4.Location = new System.Drawing.Point(261, 173);
            this.metroLabel4.Name = "metroLabel4";
            this.metroLabel4.Size = new System.Drawing.Size(78, 19);
            this.metroLabel4.TabIndex = 6;
            this.metroLabel4.Text = "Quantidade";
            // 
            // dtEntradaCadastrar
            // 
            this.dtEntradaCadastrar.Location = new System.Drawing.Point(25, 256);
            this.dtEntradaCadastrar.MinimumSize = new System.Drawing.Size(0, 29);
            this.dtEntradaCadastrar.Name = "dtEntradaCadastrar";
            this.dtEntradaCadastrar.Size = new System.Drawing.Size(335, 29);
            this.dtEntradaCadastrar.TabIndex = 9;
            // 
            // metroLabel1
            // 
            this.metroLabel1.AutoSize = true;
            this.metroLabel1.Location = new System.Drawing.Point(25, 173);
            this.metroLabel1.Name = "metroLabel1";
            this.metroLabel1.Size = new System.Drawing.Size(67, 19);
            this.metroLabel1.TabIndex = 11;
            this.metroLabel1.Text = "Categoria";
            // 
            // metroLabel2
            // 
            this.metroLabel2.AutoSize = true;
            this.metroLabel2.Location = new System.Drawing.Point(25, 119);
            this.metroLabel2.Name = "metroLabel2";
            this.metroLabel2.Size = new System.Drawing.Size(65, 19);
            this.metroLabel2.TabIndex = 10;
            this.metroLabel2.Text = "Descrição";
            // 
            // metroLabel5
            // 
            this.metroLabel5.AutoSize = true;
            this.metroLabel5.Location = new System.Drawing.Point(25, 234);
            this.metroLabel5.Name = "metroLabel5";
            this.metroLabel5.Size = new System.Drawing.Size(81, 19);
            this.metroLabel5.TabIndex = 12;
            this.metroLabel5.Text = "DataEntrada";
            // 
            // btnSalvar
            // 
            this.btnSalvar.Location = new System.Drawing.Point(25, 292);
            this.btnSalvar.Name = "btnSalvar";
            this.btnSalvar.Size = new System.Drawing.Size(92, 23);
            this.btnSalvar.TabIndex = 13;
            this.btnSalvar.Text = "SALVAR";
            this.btnSalvar.UseSelectable = true;
            this.btnSalvar.Click += new System.EventHandler(this.btnSalvar_Click);
            // 
            // btnCancelar
            // 
            this.btnCancelar.Location = new System.Drawing.Point(148, 291);
            this.btnCancelar.Name = "btnCancelar";
            this.btnCancelar.Size = new System.Drawing.Size(92, 23);
            this.btnCancelar.TabIndex = 14;
            this.btnCancelar.Text = "CANCELAR";
            this.btnCancelar.UseSelectable = true;
            this.btnCancelar.Click += new System.EventHandler(this.btnCancelar_Click);
            // 
            // btnLimpar
            // 
            this.btnLimpar.Location = new System.Drawing.Point(268, 292);
            this.btnLimpar.Name = "btnLimpar";
            this.btnLimpar.Size = new System.Drawing.Size(92, 23);
            this.btnLimpar.TabIndex = 15;
            this.btnLimpar.Text = "LIMPAR";
            this.btnLimpar.UseSelectable = true;
            this.btnLimpar.Click += new System.EventHandler(this.btnLimpar_Click);
            // 
            // txtDescricaoCadastrar
            // 
            this.txtDescricaoCadastrar.Lines = new string[0];
            this.txtDescricaoCadastrar.Location = new System.Drawing.Point(25, 141);
            this.txtDescricaoCadastrar.MaxLength = 32767;
            this.txtDescricaoCadastrar.Multiline = true;
            this.txtDescricaoCadastrar.Name = "txtDescricaoCadastrar";
            this.txtDescricaoCadastrar.PasswordChar = '\0';
            this.txtDescricaoCadastrar.ScrollBars = System.Windows.Forms.ScrollBars.None;
            this.txtDescricaoCadastrar.SelectedText = "";
            this.txtDescricaoCadastrar.Size = new System.Drawing.Size(226, 29);
            this.txtDescricaoCadastrar.TabIndex = 16;
            this.txtDescricaoCadastrar.UseSelectable = true;
            // 
            // txtPrecoCadastrar
            // 
            this.txtPrecoCadastrar.Location = new System.Drawing.Point(261, 141);
            this.txtPrecoCadastrar.Name = "txtPrecoCadastrar";
            this.txtPrecoCadastrar.Size = new System.Drawing.Size(100, 20);
            this.txtPrecoCadastrar.TabIndex = 17;
            // 
            // metroLabel6
            // 
            this.metroLabel6.AutoSize = true;
            this.metroLabel6.Location = new System.Drawing.Point(25, 65);
            this.metroLabel6.Name = "metroLabel6";
            this.metroLabel6.Size = new System.Drawing.Size(77, 19);
            this.metroLabel6.TabIndex = 18;
            this.metroLabel6.Text = "Fornecedor";
            // 
            // cboFornecedorCadastrarItem
            // 
            this.cboFornecedorCadastrarItem.FormattingEnabled = true;
            this.cboFornecedorCadastrarItem.ItemHeight = 23;
            this.cboFornecedorCadastrarItem.Location = new System.Drawing.Point(26, 88);
            this.cboFornecedorCadastrarItem.Name = "cboFornecedorCadastrarItem";
            this.cboFornecedorCadastrarItem.Size = new System.Drawing.Size(334, 29);
            this.cboFornecedorCadastrarItem.TabIndex = 19;
            this.cboFornecedorCadastrarItem.UseSelectable = true;
            // 
            // frmCadastrarItem
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(386, 381);
            this.Controls.Add(this.cboFornecedorCadastrarItem);
            this.Controls.Add(this.metroLabel6);
            this.Controls.Add(this.txtPrecoCadastrar);
            this.Controls.Add(this.txtDescricaoCadastrar);
            this.Controls.Add(this.btnLimpar);
            this.Controls.Add(this.btnCancelar);
            this.Controls.Add(this.btnSalvar);
            this.Controls.Add(this.metroLabel5);
            this.Controls.Add(this.metroLabel1);
            this.Controls.Add(this.metroLabel2);
            this.Controls.Add(this.dtEntradaCadastrar);
            this.Controls.Add(this.txtQtdeCadastrar);
            this.Controls.Add(this.metroLabel4);
            this.Controls.Add(this.metroLabel3);
            this.Controls.Add(this.cboCategoriaCadastrar);
            this.Name = "frmCadastrarItem";
            this.Text = "CADASTRAR ITEM";
            this.TextAlign = MetroFramework.Forms.MetroFormTextAlign.Center;
            this.Load += new System.EventHandler(this.frmCadastrarItem_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private MetroFramework.Controls.MetroComboBox cboCategoriaCadastrar;
        private MetroFramework.Controls.MetroLabel metroLabel3;
        private MetroFramework.Controls.MetroTextBox txtQtdeCadastrar;
        private MetroFramework.Controls.MetroLabel metroLabel4;
        private MetroFramework.Controls.MetroDateTime dtEntradaCadastrar;
        private MetroFramework.Controls.MetroLabel metroLabel1;
        private MetroFramework.Controls.MetroLabel metroLabel2;
        private MetroFramework.Controls.MetroLabel metroLabel5;
        private MetroFramework.Controls.MetroButton btnSalvar;
        private MetroFramework.Controls.MetroButton btnCancelar;
        private MetroFramework.Controls.MetroButton btnLimpar;
        private MetroFramework.Controls.MetroTextBox txtDescricaoCadastrar;
        private System.Windows.Forms.MaskedTextBox txtPrecoCadastrar;
        private MetroFramework.Controls.MetroLabel metroLabel6;
        private MetroFramework.Controls.MetroComboBox cboFornecedorCadastrarItem;
    }
}