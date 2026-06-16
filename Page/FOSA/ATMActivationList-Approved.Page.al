page 50138 "ATM Activation List-Approved"
{
    // version TL2.0

    Caption = 'Approved ATM Activations';
    CardPageID = "ATM Activation";
    PageType = List;
    SourceTable = "ATM Activation Header";
    SourceTableView = WHERE(Status = FILTER(Approved));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = All;
                }
                field("Card No."; Rec."Card No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
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

