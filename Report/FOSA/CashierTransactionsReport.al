report 50014 "Cashier Transactions Report"
{
    ApplicationArea = All;
    Caption = 'Cashier Transactions Report';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Report/FOSA/Cashier Transactions.rdl';
    dataset
    {
        dataitem("Bank Account"; "Bank Account")
        {
            RequestFilterFields = "No.", "Date Filter";
            DataItemTableView = where("Account Type" = filter("Till Account"));
            column(OpenBal; OpenBal)
            {

            }
            column(ClosingBal; ClosingBal)
            {

            }
            dataitem(BankAccountLedgerEntry; "Bank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No." = field("No."), "Posting Date" = field("Date Filter");
                column(PostingDate; "Posting Date")
                {
                }
                column(DocumentNo; "Document No.")
                {
                }
                column(Description; Description)
                {
                }
                column(DebitAmount; "Debit Amount")
                {
                }
                column(CreditAmount; "Credit Amount")
                {
                }
                column(RunningBalance; "Running Balance")
                {
                }
                column(Reversed; Reversed)
                {
                }
                column(User_ID; "User ID")
                {
                }
            }
            trigger OnPreDataItem()
            begin
            end;

            trigger OnAfterGetRecord()
            begin
                FnUpdateRemainingBal();
                OpenBal := 0;
                ClosingBal := 0;
                PrevDate := CalcDate('-1D', GetRangeMin("Bank Account"."Date Filter"));
                BankL.Reset();
                BankL.SetRange("Bank Account No.", "Bank Account"."No.");
                BankL.SetFilter("Posting Date", '..%1', PrevDate);
                if BankL.FindSet() then begin
                    BankL.CalcSums(Amount);
                    OpenBal := BankL.Amount;
                end;
                BankL.Reset();
                BankL.SetRange("Bank Account No.", "Bank Account"."No.");
                BankL.SetRange("Posting Date", GetRangeMin("Bank Account"."Date Filter"));
                if BankL.FindLast() then begin
                    ClosingBal := BankL."Running Balance";
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    procedure FnUpdateRemainingBal()
    var
        ObjBank: Record "Bank Account";
        ObjBL: Record "Bank Account Ledger Entry";
        RunningBalance: Decimal;
    begin
        ObjBank.RESET;
        ObjBank.SETCURRENTKEY("No.");
        IF ObjBank.FIND('-') THEN BEGIN
            REPEAT
                RunningBalance := 0;
                ObjBL.RESET;
                ObjBL.SETCURRENTKEY("Posting Date", "Entry No.");
                ObjBL.ASCENDING();
                ObjBL.SETRANGE(ObjBL."Bank Account No.", ObjBank."No.");
                IF ObjBL.FINDSET(TRUE) THEN BEGIN
                    REPEAT
                        RunningBalance := ObjBL.Amount + RunningBalance;
                        ObjBL."Running Balance" := RunningBalance;
                        ObjBL.MODIFY;
                    UNTIL ObjBL.NEXT = 0;
                END;
            UNTIL ObjBank.NEXT = 0;
        END;
    end;

    var
        PrevDate: Date;
        OpenBal: Decimal;
        ClosingBal: Decimal;
        BankL: Record "Bank Account Ledger Entry";
}
