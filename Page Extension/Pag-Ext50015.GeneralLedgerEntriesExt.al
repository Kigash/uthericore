pageextension 50015 "General Ledger Entries Ext" extends "General Ledger Entries"
{
    layout
    {
        addafter("G/L Account No.")
        {
            field("G/L Account Name_"; Rec."G/L Account Name")
            {
                Caption = 'G/L Account Name';
                ApplicationArea = All;
            }
        }
        addbefore("Bal. Account Type")
        {
            field("Running Balance"; RunningBalance)
            {
                Caption = 'Running Balance';
                ApplicationArea = All;
            }
            field("UserID"; Rec."User ID")
            {
                Caption = 'User ID';
                ApplicationArea = All;
            }
            field("Transaction Type Code"; Rec."Transaction Type Code")
            {
                Caption = 'Transaction Type Code';
                ApplicationArea = All;
            }
            field("Transaction No."; Rec."Transaction No.")
            {
                Caption = 'Transaction No.';
                ApplicationArea = All;
            }
            field("Member No."; Rec."Member No.")
            {
                Caption = 'Member No.';
                ApplicationArea = All;
            }
            field("Member Name"; Rec."Member Name")
            {
                Caption = 'Member Name';
                ApplicationArea = All;
            }
            field("Product Name"; Rec."Product Name")
            {
                Caption = 'Product Name';
                ApplicationArea = All;
            }
        }
        addafter("External Document No.")
        {
            field(SystemCreatedAt; Rec."SystemCreatedAt")
            {
                Caption = 'Created At';
                Editable = false;
                ApplicationArea = All;
            }
            field(SystemModifiedAt; Rec."SystemModifiedAt")
            {
                Caption = 'Modified At';
                Editable = false;
                ApplicationArea = All;
            }
        }
        addbefore(Amount)
        {
            field("DebitAmount"; Rec."Debit Amount")
            {
                Caption = 'Debit Amount';
                ApplicationArea = All;
            }
            field("CreditAmount"; Rec."Credit Amount")
            {
                Caption = 'Credit Amount';
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
        if (Rec."Member No." = '') or (Rec."Member Name" = '') or (Rec."Product Name" = '') or (Rec."Global Dimension 1 Code" = '') then begin
            FnIsMemberTransaction(Rec."Transaction No.", Rec."Member No.", Rec."Member Name", Rec."Document No.", Rec."Product Name", Rec."Global Dimension 1 Code", Rec.Amount);
            Rec.Modify;
        end;

        RunningBalance := 0;
        if GLBalances.Get(Rec."Entry No.", RunningBalance) then
            exit;
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

    procedure FnIsMemberTransaction(TransNo: Integer; Var MemberNo: Code[20]; Var MemberName: Text[100]; DocNo: Code[20]; var ProductName: Text[100]; GlobalDim1Code: Code[20]; Amount: Decimal);
    var
        Vend: Record Vendor;
        VendLedgerEntry: Record "Vendor Ledger Entry";
        Cust: Record Customer;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        TellerLine: Record "Teller Transaction Line";
    begin
        MemberNo := '';
        MemberName := '';
        ProductName := '';
        GlobalDim1Code := '';


        VendLedgerEntry.RESET;
        VendLedgerEntry.SETRANGE("Transaction No.", TransNo);
        VendLedgerEntry.SetRange("Document No.", DocNo);
        if Amount > 0 then
            VendLedgerEntry.SetRange("Amount", Amount)
        else
            VendLedgerEntry.SetRange("Amount", -Amount);
        IF VendLedgerEntry.FINDFIRST THEN BEGIN
            Vend.RESET;
            Vend.SETRANGE("No.", VendLedgerEntry."Vendor No.");
            IF Vend.FINDFIRST THEN BEGIN
                MemberNo := Vend."Member No.";
                MemberName := Vend."Member Name";
                GlobalDim1Code := Vend."Global Dimension 1 Code";
                ProductName := Vend.Name;
            END;
        END;


        CustLedgerEntry.RESET;
        CustLedgerEntry.SETRANGE("Transaction No.", TransNo);
        CustLedgerEntry.SetRange("Document No.", DocNo);
        if Amount > 0 then
            CustLedgerEntry.SetRange("Amount", Amount)
        else
            CustLedgerEntry.SetRange("Amount", -Amount);
        IF CustLedgerEntry.FINDFIRST THEN BEGIN
            Cust.RESET;
            Cust.SETRANGE("No.", CustLedgerEntry."Customer No.");
            IF Cust.FINDFIRST THEN BEGIN
                MemberNo := Cust."Member No.";
                MemberName := Cust."Member Name";
                GlobalDim1Code := Cust."Global Dimension 1 Code";
                ProductName := Cust.Name;
            END;
        END;

        if (MemberNo = '') and (MemberName = '') and (ProductName = '') and (GlobalDim1Code = '') then begin
            VendLedgerEntry.RESET;
            VendLedgerEntry.SETRANGE("Transaction No.", TransNo);
            IF VendLedgerEntry.FINDFIRST THEN BEGIN
                Vend.RESET;
                Vend.SETRANGE("No.", VendLedgerEntry."Vendor No.");
                IF Vend.FINDFIRST THEN BEGIN
                    MemberNo := Vend."Member No.";
                    MemberName := Vend."Member Name";
                    GlobalDim1Code := Vend."Global Dimension 1 Code";
                END;
            END;

            CustLedgerEntry.RESET;
            CustLedgerEntry.SETRANGE("Transaction No.", TransNo);
            IF CustLedgerEntry.FINDFIRST THEN BEGIN
                Cust.RESET;
                Cust.SETRANGE("No.", CustLedgerEntry."Customer No.");
                IF Cust.FINDFIRST THEN BEGIN
                    MemberNo := Cust."Member No.";
                    MemberName := Cust."Member Name";
                    GlobalDim1Code := Cust."Global Dimension 1 Code";
                END;
            END;
        end;


        TellerLine.RESET;
        TellerLine.SETRANGE("Transaction No.", DocNo);
        if Amount > 0 then
            TellerLine.SETRANGE("Line Amount", Amount)
        else
            TellerLine.SETRANGE("Line Amount", -Amount);
        IF TellerLine.FINDFIRST THEN BEGIN
            If MemberNo = '' then begin
                MemberNo := TellerLine."Member No.";
                MemberName := TellerLine."Member Name";
            end;
            ProductName := TellerLine."Account Name";
        END;
    end;

    var
        BankL: Record "Bank Account Ledger Entry";
        RunningBalance: Decimal;
        GLBalances: Dictionary of [Integer, Decimal];
}
