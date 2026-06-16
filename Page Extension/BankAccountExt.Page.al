pageextension 50194 "Bank Account Ext" extends "Bank Account Card"
{
    layout
    {
        addafter(Blocked)
        {
            field("Account Type"; Rec."Account Type")
            {
                ApplicationArea = All;
            }
            field("Paybill Bank"; Rec."Paybill Bank")
            {
                ApplicationArea = all;
            }
            field(Agent; Rec.Agent)
            {
                ApplicationArea = all;
            }
            field("Agent Phone No."; Rec."Agent Phone No.")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter(Statistics)
        {
            action(UpdateRunBal)
            {
                Visible = false;
                trigger OnAction()
                var
                    Bank: Record "Bank Account";
                    BankL: Record "Bank Account Ledger Entry";
                begin
                    Bank.Reset();
                    if Bank.FindSet() then begin
                        repeat
                            BankL.Reset();
                            BankL.SetRange("Bank Account No.", Bank."No.");
                            if BankL.FindFirst() then begin
                                BankL."Running Balance" := BankL.Amount;
                                BankL.Modify();
                            end;
                        until Bank.Next = 0;
                    end;
                end;
            }
        }
    }

    var
        myInt: Integer;
}