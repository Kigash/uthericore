page 50476 "Employee Data Change Request"
{
    // version TL2.0

    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = 50245;
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Field Caption"; Rec."Field Caption")
                {
                    ApplicationArea = All;
                }
                field("Old Value"; Rec."Old Value")
                {
                    ApplicationArea = All;
                }
                field("New Value"; Rec."New Value")
                {
                    ApplicationArea = All;
                }
                field("Change Date"; Rec."Change Date")
                {
                    ApplicationArea = All;
                }
                field("Change Time"; Rec."Change Time")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Approver; Rec.Approver)
                {
                    ApplicationArea = All;
                }
                field("Approval Date"; Rec."Approval Date")
                {
                    ApplicationArea = All;
                }
                field("Approval Time"; Rec."Approval Time")
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
            action("View Employee Card")
            {
                Image = Employee;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunPageMode = View;
                ApplicationArea = All;
            }
        }
    }

    var
        Employee: Record 5200;
        DimensionValue: Record 349;
        Date1: Date;
        Date2: Date;
        CurrentYear: Integer;
        YearOfBirth: Integer;
        Employee2: Record 5200;
        NoSeriesManagement: Codeunit "No. Series";HRSetup: Record 5218;
}
