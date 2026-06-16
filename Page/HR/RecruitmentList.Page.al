page 50477 "Recruitment List"
{
    // version TL2.0

    CardPageID = "Recruitment Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = 50246;
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
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                }
                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = All;
                }
                field("Department Requested"; Rec."Department Requested")
                {
                    ApplicationArea = All;
                }
                field("Requested Positions"; Rec."Requested Positions")
                {
                    ApplicationArea = All;
                }
                field("Recruitment Date"; Rec."Recruitment Date")
                {
                    ApplicationArea = All;
                }
                field("Recruitment Type"; Rec."Recruitment Type")
                {
                    ApplicationArea = All;
                }
                field("Request Done By"; Rec."Request Done By")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Branch; Rec.Branch)
                {
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
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
