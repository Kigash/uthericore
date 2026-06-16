page 50463 "Training Request Lines"
{
    // version TL2.0

    PageType = ListPart;
    SourceTable = 50235;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
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
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;
                }
                field("Confirmation Date"; Rec."Confirmation Date")
                {
                    ApplicationArea = All;
                }
                field("Employment Status"; Rec."Employment Status")
                {
                    ApplicationArea = All;
                }

                field("Training Cost"; Rec."Training Cost")
                {
                    ApplicationArea = All;
                }
                field("Other Costs"; Rec."Other Costs")
                {
                    ApplicationArea = All;
                }
                field("Total Cost"; Rec."Total Cost")
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        Visibility;
    end;

    var
        SeeAllowances: Boolean;

    local procedure Visibility();
    var
        TrainingRequest: Record 50234;
    begin
        IF TrainingRequest.GET(Rec."Training Request No.") THEN BEGIN
            IF TrainingRequest."Submitted To HR" THEN BEGIN
                SeeAllowances := TRUE;
            END ELSE BEGIN
                SeeAllowances := FALSE;
            END;
        END;
    end;
}
