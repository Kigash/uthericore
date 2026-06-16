report 51104 "Teller Transaction ReceiptN"
{

    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report/FOSA/TellerTransactionReceiptNew.rdl';

    dataset
    {
        dataitem("Teller Transaction Header"; "Teller Transaction Header")
        {
            RequestFilterFields = "No.";
            DataItemTableView = order(ascending);
            column(No_; "No.")
            {
            }
            column(Member_No_; "Member No.")
            {
            }
            column(Member_Name; "Member Name")
            {
            }
            column(Description; Description)
            {
            }
            column(Transaction_Date; "Transaction Date")
            {
            }
            column(Transaction_Time; "Transaction Time")
            {

            }
            column(Teller_User_ID; "Teller User ID")
            {

            }
            column(Total_Amount; "Total Line Amount")
            {

            }
            column(Picture; CompInfo.Picture)
            {

            }
            column(CompName; CompInfo.Name)
            {

            }
            column(AmountInWords; AmountInWords)
            {

            }
            column(PhoneNo; PhoneNo)
            { }
            column(Narration; Narration)
            { }
            dataitem("Teller Transaction Line"; "Teller Transaction Line")
            {
                DataItemLink = "Transaction No." = field("No.");
                DataItemTableView = order(ascending);

                column(Account_Type; "Account Type")
                {

                }
                column(Account_No_; "Account No.")
                {

                }
                column(Account_Name; "Account Name")
                {

                }
                column(Line_Amount; "Line Amount")
                {

                }
                column(Transaction_Type; "Transaction Type")
                {
                }
                column(Transaction_Charge; "Transaction Charge")
                {
                }
                column(TotalLAmount; TotalLAmount)
                {
                }
                column(LAmount; LAmount)
                { }
                trigger OnPreDataItem()
                begin
                    TotalLAmount := 0;
                end;

                trigger OnAfterGetRecord()
                begin
                    LAmount := 0;
                    If "Debit Amount" = 0 then begin
                        LAmount := "Credit Amount";
                        TotalLAmount += (LAmount * -1)
                    end else begin
                        LAmount := "Debit Amount";
                        TotalLAmount += LAmount;
                    end;
                end;
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                Memb: Record Member;
            begin
                CalcFields("Total Line Amount");
                AmountInWords := GlobalManagement.GetAmountInWords("Total Line Amount");
                Memb.Get("Member No.");
                PhoneNo := Memb."Phone No.";
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    /*  field(Name; SourceExpression)
                    {
                        ApplicationArea = All;

                    }  */
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        CompInfo.Get();
        CompInfo.CalcFields(Picture)
    end;

    var
        CompInfo: Record "Company Information";
        GlobalManagement: Codeunit "Global Management";
        AmountInWords: Text[300];
        LAmount: Decimal;
        TotalLAmount: Decimal;
        PhoneNo: Code[100];
}