page 50140 "ATM Ledger Entries"
{
    // version TL2.0

    Editable = false;
    PageType = List;
    SourceTable = "ATM Ledger Entry";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Transaction No."; Rec."Transaction No.")
                {
                    ApplicationArea = All;
                }
                field("Card No."; Rec."Card No.")
                {
                    ApplicationArea = All;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = All;
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

