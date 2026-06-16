page 59160 "Cashier Account Card"
{
    Caption = 'Cashier Account Card';
    PageType = Card;
    SourceTable = "Bank Account";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the bank account.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the bank where you have the bank account.';
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Account Type field.';
                }
                field("Bank Acc. Posting Group"; Rec."Bank Acc. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a code for the bank account posting group for the bank account.';
                }
                field("Cashier Balance"; Rec."Cashier Balance")
                {

                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Account Type" := Rec."Account Type"::"Till Account"
    end;
}
