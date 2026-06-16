page 50519 "Submitted Employee Eval."
{
    CardPageID = "Employee Training Evaluation";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 50275;
    SourceTableView = WHERE(Submitted = FILTER('Yes'));
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
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                }
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;
                }
                field("Course/Seminar Name"; Rec."Course/Seminar Name")
                {
                    ApplicationArea = All;
                }
                field("Training Institution"; Rec."Training Institution")
                {
                    ApplicationArea = All;
                }
                field(Venue; Rec.Venue)
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Branch Name"; Rec."Branch Name")
                {
                    ApplicationArea = All;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        CurrPage.EDITABLE(FALSE);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Error(Error000);
    end;

    trigger OnModifyRecord(): Boolean;
    begin
        Error(Error001);
    end;

    var
        Error000: Label 'You cannot create a new record!';
        Error001: Label 'You cannot modify this record!';
}
