page 50486 HRCuePage
{
    PageType = CardPart;
    SourceTable = "HR Cue";

    layout
    {
        area(content)
        {
            cuegroup(Employees)
            {
                //  CuegroupLayout = Wide;

                field("Active Employees"; Rec."Active Employees")
                {
                    ApplicationArea = All;
                    Caption = 'Active Employees';
                    DrillDownPageId = "Employee List";
                }
                field("Employees on Probation"; Rec."Employees on Probation")
                {
                    ApplicationArea = All;
                    Caption = 'Employees on Probation';
                    DrillDownPageId = "Employees On Probation";
                }
                field("Total Employees"; Rec."Total Employees")
                {
                    ApplicationArea = All;
                    Caption = 'Total Employees';
                    DrillDownPageId = "Employee List";
                }
            }
            cuegroup("Leave Applications")
            {
                // CuegroupLayout = Wide;
                field("New Leave Applications"; Rec."New Leave Applications")
                {
                    ApplicationArea = All;
                    Caption = 'New Leave Applications';
                    DrillDownPageId = "Leave Application List";
                }
                field("Leave Appl. Pending Approval"; Rec."Leave Appl. Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Leave Applications Pending Approval';
                    DrillDownPageId = "Leave App. Pending Approval";
                }
                field("Approved Leave Applications"; Rec."Approved Leave Applications")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Leave Applications';
                    DrillDownPageId = "Approved Leave Application";
                }
            }

            cuegroup("Training Requests")
            {
                field("New Training Request"; Rec."New Training Request")
                {
                    ApplicationArea = All;
                    Caption = 'New Training Request';
                    DrillDownPageId = "Training Request List";
                }
                field("Training Req. Pending Approval"; Rec."Training Req. Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Training Request Pending Approval';
                    DrillDownPageId = "Training Req. Pending Approval";
                }

                field("Approved Training Request"; Rec."Approved Training Request")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Training Request';
                    DrillDownPageId = "Approved Training Requests";
                }
            }


        }
    }



    trigger OnOpenPage();
    begin
        Rec.RESET;
        if not Rec.get then begin
            Rec.INIT;
            Rec.INSERT;
        end;
    end;
}