page 50468 "Separation List-Processing"
{
    CardPageID = "Separation Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = Separation;
    SourceTableView = WHERE("Separation Status" = filter('Processing'));
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Separation No"; Rec."Separation No")
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
                field("Employment Date"; Rec."Employment Date")
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
                field("Separation Type"; Rec."Separation Type")
                {
                    ApplicationArea = All;
                }
                field("Notification Start Date"; Rec."Notification Start Date")
                {
                    ApplicationArea = All;
                }
                field("Notice Period"; Rec."Notice Period")
                {
                    ApplicationArea = All;
                }
                field("Notification End Date"; Rec."Notification End Date")
                {
                    ApplicationArea = All;
                }
                field("Last Working Date"; Rec."Last Working Date")
                {
                    ApplicationArea = All;
                }
                field("In Lieu of Notice"; Rec."In Lieu of Notice")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
        }
    }
}
