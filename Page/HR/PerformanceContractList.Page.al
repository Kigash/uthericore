page 50930 "Performance Contract List"
{
    // version TL2.0

    CardPageID = "Performance Contract Header";
    PageType = List;
    SourceTable = "Performance Contract";
    SourceTableView=where(Submitted=filter('No'));
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Appraisal Year"; Rec."Appraisal Year")
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
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                }
                field(Branch; Rec."Branch Name")
                {
                    ApplicationArea = All;
                }
                 field(Department; Rec."Department Name")
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
