page 55101 "MC Cue"
{
    PageType = CardPart;
    SourceTable = "MicroCredit Cue";

    layout
    {
        area(content)
        {
            cuegroup(Loans)
            {
                CuegroupLayout = Wide;
                field("Outstanding Loan Balance"; Rec."Outstanding Loan Balance")
                {
                    DrillDownPageId = "Loan Applications List-Posted";
                }
                field("Unallocated Group Collections"; Rec."Unallocated Group Collections")
                {
                    DrillDownPageId = "Group Collection Entries";
                }
                field("Total Deposits"; Rec."Total Deposits")
                {
                    DrillDownPageId = "Member S/Dep. Account List";
                }
                field("Total Share Capital"; Rec."Total Share Capital")
                {
                    DrillDownPageId = "Member S/Dep. Account List";
                }
            }
            cuegroup(Members)
            {
                //  CuegroupLayout = Wide;

                field("New Member Applications"; Rec."New Member Applications")
                {
                    DrillDownPageId = "Member Application List-New";
                    ApplicationArea = All;
                }
                field("Member App. Pending Approval"; Rec."Member App. Pending Approval")
                {
                    Caption = 'Member Application Pending Approval';
                    DrillDownPageId = "Member Appl. List-Pending";
                    ApplicationArea = All;
                }
                field("Approved Member Applications"; Rec."Approved Member Applications")
                {
                    DrillDownPageId = "Member Appl. List-Approved";
                    ApplicationArea = All;
                }
                field("No. of Groups"; Rec."No. of Groups")
                {
                    DrillDownPageId = "Member List";
                    ApplicationArea = All;
                }
            }
            cuegroup("Loan Applications")
            {
                // CuegroupLayout = Wide;
                field("New Loan Applications"; Rec."New Loan Applications")
                {
                    DrillDownPageId = "Loan Application List-New";
                    ApplicationArea = All;
                }
                field("Loan App. Pending Appraisal"; Rec."Loan App. Pending Appraisal")
                {
                    Caption = 'Loan Applications Pending Appraisal';
                    DrillDownPageId = "Loan Appl. List-Pending Apprsl";
                }
                field("Loan App. Pending Disbursal"; Rec."Loan App. Pending Disbursal")
                {
                    Caption = 'Loan Applications Pending Disbursal';
                    DrillDownPageId = "Loan Appl. List-Pending Dbsl";
                }
            }

        }
    }
    trigger OnOpenPage();
    begin
        Rec.RESET;
        if not Rec.GET then begin
            Rec.INIT;
            Rec."Loan Officer" := GetUser.GetUser();
            Rec.INSERT;
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.Validate("Total Deposits");
        Rec.Validate("Total Share Capital");
    end;

    var
        GetUser: Codeunit "Get User";

}