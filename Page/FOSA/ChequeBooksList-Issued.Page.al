page 50169 "Cheque Book List-Issued"
{
    // version CTS2.0

    Caption = 'Issued Cheque Books';
    CardPageID = "Cheque Book";
    Editable = false;
    PageType = List;
    SourceTable = "Cheque Book";
    SourceTableView = WHERE(Status = FILTER(Issued));

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
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                }
                field("No. of Leaves"; Rec."No. of Leaves")
                {
                    ApplicationArea = All;
                }
                field("Last Leaf Used"; Rec."Last Leaf Used")
                {
                    ApplicationArea = All;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Active; Rec.Active)
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
