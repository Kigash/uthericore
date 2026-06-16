page 50487 "Short Listed Job Application"
{
    // version TL2.0

    CardPageID = "Job Application Card";
    PageType = List;
    SourceTable = 50277;
    SourceTableView = WHERE(Status = FILTER('Shortlisted'));
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
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field("Recruitment Request No."; Rec."Recruitment Request No.")
                {
                    ApplicationArea = All;
                }
                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("National ID/Passport No."; Rec."National ID/Passport No.")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("No. Years of Experience"; Rec."No. Years of Experience")
                {
                    ApplicationArea = All;
                }
                field("Level of Education"; Rec."Level of Education")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("View Applicants")
            {
                Image = Employee;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
            }
        }
    }
}
