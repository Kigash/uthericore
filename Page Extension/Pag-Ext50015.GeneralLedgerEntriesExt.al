pageextension 50015 "General Ledger Entries Ext" extends "General Ledger Entries"
{
    layout
    {
        addbefore("Bal. Account Type")
        {
            field("Running Balance"; RunningBalance)
            {
                Caption = 'Running Balance';
                ApplicationArea = All;
            }
        }
        addafter("External Document No.")
        {
            field(SystemCreatedAt; Rec.SystemCreatedAt)
            {
                Caption = 'Created At';
                Editable = false;
                ApplicationArea = All;
            }
            field(SystemModifiedAt; Rec.SystemModifiedAt)
            {
                Caption = 'Modified At';
                Editable = false;
                ApplicationArea = All;
            }
        }
    }
    trigger OnOpenPage()
    begin
        LoadBalances();
        // FnUpdateRemainingBal(GETFILTER("G/L Account No."));
        //RunningBalance := 0;
    end;

    trigger OnAfterGetRecord()
    begin
        if GLBalances.Get(Rec."Entry No.", RunningBalance) then
            exit;
        //FnUpdateRemainingBal(Rec."G/L Account No.");
    end;

    procedure FnUpdateRemainingBal(GLAccount: Code[50])
    var
        ObjGlAcc: Record "G/L Account";
        ObjGlE: Record "G/L Entry";
    begin
        RunningBalance := 0;
        
        ObjGlE.RESET;
        ObjGlE.SETCURRENTKEY("Posting Date", "Entry No.");
        ObjGlE.ASCENDING();
        ObjGlE.SETRANGE(ObjGlE."G/L Account No.", GLAccount);
        IF ObjGlE.FINDSET(TRUE) THEN BEGIN
            REPEAT
            // RunningBalance += ObjGlE.Amount;
            //ObjGlE."Running Balance" := RunningBalance;
            //ObjGlE.MODIFY;
            UNTIL ObjGlE.NEXT = 0;
        END;
    end;

    local procedure LoadBalances()
    var
        GLEntry: Record "G/L Entry";
        AccountNo: Code[20];
        Balance: Decimal;
    begin
        // GLBalances.clear();
        Balance := 0;

        AccountNo := Rec.GetFilter("G/L Account No.");
        if AccountNo = '' then
            exit;

        GLEntry.RESET;
        GLEntry.SetCurrentKey("Posting Date", "Entry No.");
        GLEntry.SetRange("G/L Account No.", AccountNo);

        if GLEntry.FindSet() then
            repeat
                Balance += GLEntry.Amount;
                GLBalances.Add(GLEntry."Entry No.", Balance);
            until GLEntry.Next() = 0;
    end;

    var
        BankL: Record "Bank Account Ledger Entry";
        RunningBalance: Decimal;
        GLBalances: Dictionary of [Integer, Decimal];
}
