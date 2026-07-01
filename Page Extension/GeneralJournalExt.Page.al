pageextension 50006 GeneralJournalExt extends "General Journal"
{
    layout
    {
        // Add changes to page layout here
        addbefore(Amount)
        {
            field("Debit Amount2"; Rec."Debit Amount")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    if (Rec."Account Type" = Rec."Account Type"::Customer) and (Rec."Member No" <> '') then begin
                        Rec.TestField("Transaction Type Code");
                    end;
                end;
            }
            field("Credit Amount2"; Rec."Credit Amount")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    if (Rec."Account Type" = Rec."Account Type"::Customer) and (Rec."Member No" <> '') then begin
                        Rec.TestField("Transaction Type Code");
                    end;
                end;
            }

        }
        modify(Amount)
        {
            trigger OnBeforeValidate()
            begin
                if (Rec."Account Type" = Rec."Account Type"::Customer) and (Rec."Member No" <> '') then begin
                    Rec.TestField("Transaction Type Code");
                end;
            end;
        }

        addafter("Document No.")
        {
            field("Member No"; Rec."Member No")
            {
                ApplicationArea = All;
            }
        }
        addafter("Account Type")
        {
            field("Account No. 2"; Rec."Account No. 2")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    Clear(Rec."Posting Group");
                    Rec."Account No." := Rec."Account No. 2";
                    Rec.Validate("Account No.");
                end;
            }
        }
        modify("Account No.")
        {
            Visible = false;
        }
        modify("Amount (LCY)")
        {
            Visible = false;
        }

        addafter(Description)
        {
            field("Transaction Type Code"; Rec."Transaction Type Code")
            {
                ApplicationArea = All;
                trigger OnValidate()
                var
                    TransCodeSetup: Record "Transaction Type Code Setup";
                    LProd: Record "Loan Product Type";
                    Cust: Record Customer;

                begin
                    TransCodeSetup.Get();
                    if (Rec."Account Type" = Rec."Account Type"::Customer) and (Rec."Member No" <> '') then begin
                        if Rec."Account No." <> '' then begin
                            If Cust.Get(Rec."Account No.") then begin
                                LProd.Get(Cust."Customer Posting Group");
                                if (Rec."Transaction Type Code" = TransCodeSetup."Interest Due") or (Rec."Transaction Type Code" = TransCodeSetup."Interest Paid") then begin
                                    // Message('Posting Group %1', LProd."Interest Due Posting Group");
                                    Rec."Posting Group" := LProd."Interest Due Posting Group";
                                    Rec.Modify();
                                end;
                                if (Rec."Transaction Type Code" = TransCodeSetup."Penalty Due") or (Rec."Transaction Type Code" = TransCodeSetup."Penalty Paid") then begin
                                    Rec."Posting Group" := LProd."Penalty Due Posting Group";
                                    Rec.Modify();
                                end;
                                if (Rec."Transaction Type Code" = TransCodeSetup."Insurance Fee") then begin
                                    Rec."Posting Group" := '5534';
                                    Rec.Modify();
                                end;
                            end;
                            if (Rec."Amount" <> 0) then
                                Rec.TestField("Transaction Type Code");
                        end;
                    end;
                end;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        modify(Post)
        {
            trigger OnAfterAction()
            begin

            end;
        }
    }

    var
        myInt: Integer;
}