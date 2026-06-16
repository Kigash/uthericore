page 50957 "Registry File Numbers"
{
    // version TL2.0

    PageType = ListPart;
    SourceTable = "Registry File Number";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("File Status"; Rec."File Status")
                {
                    ApplicationArea = All;
                }
                field("File Number"; Rec."File Number")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Changed By"; Rec."Changed By")
                {
                    ApplicationArea = All;
                }
                field("Previous File Number"; Rec."Previous File Number")
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

