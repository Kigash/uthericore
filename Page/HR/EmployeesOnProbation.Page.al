page 50444 "Employees On Probation"
{
    // version TL2.0

    Caption = 'Employees On Probation';
    CardPageID = "Employee Card TL";
    Editable = false;
    PageType = List;
    SourceTable = Employee;
    SourceTableView = WHERE("Employee Status" = filter('Probation'));
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies a number for the employee.';
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = BasicHR;
                    NotBlank = true;
                    ToolTip = 'Specifies the employee''s first name.';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the employee''s middle name.';
                    Visible = false;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = BasicHR;
                    NotBlank = true;
                    ToolTip = 'Specifies the employee''s last name.';
                }
                field(FullName; Rec.FullName)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Full Name';
                    ToolTip = 'Specifies the full name of the employee.';
                    Visible = false;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the employee''s job title.';
                }
                field("Branch Name"; Rec."Branch Name")
                {
                }
                field("Department Name"; Rec."Department Name")
                {
                }
                field("Employment Date"; Rec."Employment Date")
                {
                }
                field("Probation End Date"; Rec."Probation End Date")
                {
                }
            }
        }
    }
}
