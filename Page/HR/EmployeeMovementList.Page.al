page 50446 "Employee Movement List"
{
    // version TL2.0

    CardPageID = "Employee Movement";
    PageType = List;
    SourceTable = 50229;
    SourceTableView = WHERE(Status = FILTER('Open'));
    UsageCategory = Lists;
    ApplicationArea = all;

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
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;
                }
                field(Branch; Rec."Current Branch")
                {
                    ApplicationArea = All;
                }
                field(Department; Rec."Current Department")
                {
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Current Job Tiltle")
                {
                    ApplicationArea = All;
                }
                field(Grade; Rec."Current Grade")
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
