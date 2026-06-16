pageextension 50050 BankReconciliationLinesExt extends "Bank Acc. Reconciliation Lines"
{
    layout
    {
        // Add changes to page layout here
        addafter("Transaction Date")
        {
            field("External Doc No"; Rec."External Doc No")
            {
                ApplicationArea = All;
            }
        }
        addafter("Statement Amount")
        {
            field("Debit Amount"; Rec."Debit Amount")
            {
                ApplicationArea = All;
            }
            field("Credit Amount"; Rec."Credit Amount")
            {
                ApplicationArea = All;
            }
        }
        modify("Document No.")
        {
            Visible = true;
        }
    }

    actions
    {
        // Add changes to page actions here

    }
    trigger OnOpenPage()
    var
        BankRecL: Record "Bank Acc. Reconciliation Line";
        Total: Decimal;
    begin
        Total := 0;
        BankRecL.Reset();
        BankRecL.SetRange(BankRecL."Document No.", Rec."Document No.");
        if BankRecL.Count > 0 then begin
            /*
                        BankRecL.Reset();
                        BankRecL.SetRange(BankRecL."Document No.", "Document No.");
                        BankRecL.SetRange(BankRecL."Transaction Date", "Transaction Date");
                        BankRecL.SetRange(BankRecL.Description, Description);
                        BankRecL.SetRange(BankRecL."Statement Amount", "Statement Amount");
                        BankRecL.SetRange(BankRecL."External Doc No", "External Doc No");
                        if BankRecL.FindSet() then begin
                            Total := 0;
                            repeat
                                Total += 1
                            until BankRecL.Next = 0;
                        end;

                        if Total > 1 then begin
                            BankRecL.Reset();
                            //BankRecL.CalcFields(BankRecL."Applied Amount");
                            BankRecL.SetRange(BankRecL."Document No.", "Document No.");
                            BankRecL.SetRange(BankRecL."Transaction Date", "Transaction Date");
                            BankRecL.SetRange(BankRecL.Description, Description);
                            BankRecL.SetRange(BankRecL."Statement Amount", "Statement Amount");
                            BankRecL.SetRange(BankRecL."External Doc No", "External Doc No");
                            BankRecL.SetFilter(BankRecL."Applied Amount", '>%1', 0);
                            if BankRecL.FindFirst() then begin
                                BankRecL.Delete();
                            end;
                        end;
                        */
        end;
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        BankL: Record "Bank Account Ledger Entry";
    begin
        // rec.SetCurrentKey("Transaction Date");
        //rec.SetAscending("Transaction Date", true);

        if Rec."Statement Amount" > 0 then
            Rec."Debit Amount" := Rec."Statement Amount"
        else
            Rec."Credit Amount" := Rec."Statement Amount";

        Rec.Modify();
        BankL.Reset();
        BankL.SetRange(BankL."Document No.", Rec."Document No.");
        BankL.SetRange(BankL.Description, Rec."Description");
        BankL.SetRange(BankL.Amount, Rec."Statement Amount");
        BankL.SetRange(BankL."Posting Date", Rec."Transaction Date");
        if BankL.FindFirst() then begin
            Rec."External Doc No" := BankL."External Document No.";
            Rec."Document No." := BankL."Document No.";
            Rec.Modify();
        end;

    end;

}