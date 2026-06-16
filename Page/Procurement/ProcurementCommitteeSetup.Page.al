page 50753 "Procurement Committee Setup"
{
    // version TL2.0

    PageType = List;
    SourceTable = "Procurement Committee Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Minimum Members"; Rec."Minimum Members")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Process Type"; Rec."Process Type")
                {
                    ApplicationArea = All;
                }
                field("Process Stage"; Rec."Process Stage")
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

