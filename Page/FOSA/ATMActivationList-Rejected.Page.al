page 50139 "ATM Activation List-Rejected"
{
    // version TL2.0

    Caption = 'Rejected ATM Activations';
    CardPageID = "ATM Activation";
    PageType = List;
    SourceTable = "ATM Activation Header";
    SourceTableView = WHERE(Status = FILTER(Rejected));

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

