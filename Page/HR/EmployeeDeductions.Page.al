page 50510 "Employee Deductions"
{
    // version TL2.0

    DataCaptionFields = "Employee No", "Employee Name";
    PageType = Card;
    SourceTable = 50273;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Employee No"; Rec."Employee No")
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
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                }
                part("Employee Deduction Lines"; 50511)
                {
                    SubPageLink = "Employee No" = FIELD("Employee No");
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}
