page 50532 "Performance Review List"
{
    // version TL2.0

    CardPageID = "Performance Review Card";
    PageType = List;
    SourceTable = 50286;
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Period; Rec.Period)
                {
                    ApplicationArea = All;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field(Branch; Rec."Branch Name")
                {
                    ApplicationArea = All;
                }
                field(Department; Rec."Department Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                }
                field("Employment Date"; Rec."Employment Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}
