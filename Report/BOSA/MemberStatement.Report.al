report 50082 "Member Statement"
{
    // version TL2.0

    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = 'Report/BOSA/Member Statement.rdl';

    dataset
    {
        dataitem(DataItem1; Member)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(No_Member; "No.")
            {
            }
            column(Surname_Member; Surname)
            {
            }
            column(FullName_Member; "Full Name")
            {
            }
            column(GlobalDimension1Code_Member; "Global Dimension 1 Code")
            {
            }
            column(Phone_No_; "Phone No.")
            {
            }
            column(National_ID; "National ID")
            {
            }
            column(Picture; CompanyInfo.Picture) { }
            column(Name; CompanyInfo.Name) { }
            dataitem(DataItem7; Vendor)
            {
                DataItemLink = "Member No." = FIELD("No.");
                DataItemTableView = SORTING("No.");
                column(No_Vendor; "No.")
                {
                }
                column(Name_Vendor; Name)
                {
                }
                column(BalanceLCY_Vendor; "Balance (LCY)")
                {
                }
                column(Amount1; Amount1)
                {

                }
                column(Account_Type; "Account Type")
                {

                }
                dataitem(DataItem6; "Vendor Ledger Entry")
                {
                    // RequestFilterFields = "Posting Date";
                    DataItemLink = "Vendor No." = FIELD("No.");
                    DataItemTableView = SORTING("Posting Date") order(ascending);
                    column(VendorNo_VendorLedgerEntry; "Vendor No.")
                    {
                    }
                    column(PostingDate_VendorLedgerEntry; "Posting Date")
                    {
                    }
                    column(DocumentType_VendorLedgerEntry; "Document Type")
                    {
                    }
                    column(DocumentNo_VendorLedgerEntry; "Document No.")
                    {
                    }
                    column(Description_VendorLedgerEntry; Description)
                    {
                    }
                    column(CurrencyCode_VendorLedgerEntry; "Currency Code")
                    {
                    }
                    column(Amount_VendorLedgerEntry; Amount)
                    {
                    }
                    column(RemainingAmount_VendorLedgerEntry; "Remaining Amount")
                    {
                    }
                    column(Debit_Amount; "Debit Amount")
                    {
                    }
                    column(Credit_Amount; "Credit Amount")
                    {
                    }
                    column(Reversed; Reversed)
                    {
                    }
                    column(RunningBalance; RunningBalance)
                    {

                    }
                    trigger OnPreDataItem()
                    var
                    begin
                        Amount1 := 0;

                        if (StartDate <> 0D) or (EndDate <> 0D) THEN
                            SetRange("Posting Date", StartDate, EndDate);

                        If StartDate <> 0D then begin
                            VendL.Reset();
                            VendL.SetRange("Vendor No.", DataItem7."No.");
                            VendL.SetFilter("Posting Date", '<%1', StartDate);
                            If VendL.FindSet() then begin
                                repeat
                                    VendL.CalcFields(Amount);
                                    RunningBalance += VendL.Amount;
                                    Amount1 += Abs((vendl.Amount));
                                until VendL.Next = 0;
                            end;
                        end;
                        if Acctype <> '' then
                            DataItem7.SetFilter("Account Type", Acctype);
                    end;

                    trigger OnAfterGetRecord()
                    begin

                        RunningBalance += Amount;
                        if Reversed then
                            CurrReport.Skip();
                        /*If Acctype <> '' then begin
                            If DataItem7."Account Type" <> Acctype then
                                CurrReport.Skip();
                        end;*/
                    end;

                }

                trigger OnAfterGetRecord()
                begin
                    RunningBalance := 0;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(StartDate; StartDate)
                {
                    ApplicationArea = All;
                }
                field(EndDate; EndDate)
                {
                    ApplicationArea = All;
                }
                /*  field(Acctype; Acctype)
                  {
                      Caption = 'Member Account Type';
                      TableRelation = "Account Type";
                      ApplicationArea = All;
                  }*/
            }
        }

        actions
        {
        }
    }

    labels
    {
        ReportTitle = 'Member Statement';
    }

    trigger OnPreReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
    end;

    var
        BOSAManagement: Codeunit "BOSA Management";
        CompanyInfo: Record "Company Information";
        RunningBalance: Decimal;
        StartDate: Date;
        EndDate: Date;
        Amount1: Decimal;
        VendL: Record "Vendor Ledger Entry";
        Acctype: code[30];
}

