report 57794 "Teller Return Treasury"
{

    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report/FOSA/TellerReturnTreasury.rdl';

    dataset
    {
        dataitem("Teller Return Treasury"; "Teller Return Treasury")
        {
            column(No; "No.") { }
            column(TreasuryAccountNo; "Treasury Account No.") { }
            column(TransactionType; "Transaction Type") { }
            column(Description; Description) { }
            column(TillReturnAmount; "Till Return Amount") { }
            column(TillReceiveAmount; "Till Receive Amount") { }
            column(TotalCoinageAmount; "Total Coinage Amount") { }
            column(TellerUserID; "Teller User ID") { }
            column(TillNo; "Till No.") { }
            column(TillBalance; "Till Balance") { }
            column(TillMaximumLimit; "Till Maximum Limit") { }
            column(TransactionDate; "Transaction Date") { }
            column(TransactionTime; "Transaction Time") { }
            column(TellerHostIP; "Teller Host IP") { }
            column(TellerHostMAC; "Teller Host MAC") { }
            column(TellerHostName; "Teller Host Name") { }
            column(Status; Status) { }
            column(Picture; CompanyInfo.Picture) { }
            column(Name; CompanyInfo.Name) { }

            dataitem("Transaction Coinage Setup"; "Transaction Coinage Setup")
            {
                DataItemLink = "Transaction No." = field("No.");
                column(Transaction_No_; "Transaction No.") { }
                column(Quantity; Quantity) { }
                column(CoinageCode; "Coinage Code") { }
                column(CoinageValue; "Coinage Value") { }
                column(LineAmount; "Line Amount") { }
            }
        }
    }



    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field("No."; "Teller Return Treasury"."No.")
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    labels
    {
        ReportTitle = 'Teller Treasury Report';
    }

    trigger OnPreReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
}