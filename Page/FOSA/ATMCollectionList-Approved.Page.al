page 50129 "ATM Collection List-Approved"
{
    // version TL2.0

    Caption = 'Approved ATM Collections';
    CardPageID = "ATM Collection Card";
    PageType = List;
    SourceTable = "ATM Collection";
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
                field("Application No."; Rec."Application No.")
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


                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Card No."; Rec."Card No.")
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

