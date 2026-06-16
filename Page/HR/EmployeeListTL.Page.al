page 50401 "Employee List TL"
{
    PageType = List;
    Caption = 'Employee List';
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Employee Card TL";
    SourceTable = Employee;
    SourceTableView = where("Employee Status" = filter('Active|Probation|Confirmed|Suspended'));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(FullName; Rec.FullName)
                {
                    ApplicationArea = All;
                }
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;
                }
                field("Employee Type"; Rec."Employee Type")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Employee Status"; Rec."Employee Status")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}