page 50457 "Position List"
{
    // version TL2.0

    CardPageID = "Position Card";
    PageType = List;
    SourceTable = 50230;
    UsageCategory = Lists;
    ApplicationArea = all;

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
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                }
                field("Reporting To"; Rec."Reporting To")
                {
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                }
                field("No. of Posts"; Rec."No. of Posts")
                {
                    ApplicationArea = All;
                }
                field("Occupied Positions"; Rec."Occupied Positions")
                {
                    ApplicationArea = All;
                }
                field("Vacant Positions"; Rec."Vacant Positions")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        Rec.UpdateVacantPosition;
    end;
}
