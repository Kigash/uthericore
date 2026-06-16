page 50456 "Position Card"
{
    // version TL2.0

    PageType = Card;
    SourceTable = 50230;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                }
                field("Reporting To"; Rec."Reporting To")
                {
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                }
                field("No. of Posts"; Rec."No. of Posts")
                {
                    ApplicationArea = All;
                }
                field("Occupied Positions"; Rec."Occupied Positions")
                {
                    ApplicationArea = All;
                }
                field("Vacant Positions"; Rec."Vacant Positions")
                {
                    ApplicationArea = All;
                }
                field("Job Description"; Rec."Job Description")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Job KPI's"; Rec."Job KPI's")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                }
            }
            part("Position Qualifications"; "Position Qualifications")
            {
                ShowFilter = false;
                ApplicationArea = All;
                SubPageLink = "Position Code" = field(Code);
            }

            part("Position Responsibilities"; "Position Responsibilities")
            {
                ShowFilter = false;
                ApplicationArea = All;
                SubPageLink = "Position Code" = field(Code);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Current Job Occupants")
            {
                Image = SalesPurchaseTeam;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                RunObject = Page 5201;
                RunPageLink = "Job Title" = field("Job Title");
                RunPageMode = View;
            }
            action("Job Description Report")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    Position.RESET;
                    Position.SETRANGE(Code, Rec.Code);
                    IF Position.FINDFIRST THEN BEGIN
                        COMMIT;
                        REPORT.RUN(50285, TRUE, FALSE, Position);
                    END;
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        Rec.UpdateVacantPosition;
    end;

    var
        Position: Record 50230;
}
