page 50931 "Performance Review Card"
{
    // version TL2.0
    Caption = 'Performance Review';
    PageType = Card;
    SourceTable = "Performance Review Header";
    DataCaptionFields = Period, "Full Name";

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = EditEmployeeComments;
                field(Period; Rec.Period)
                {
                    ApplicationArea = All;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Full Name"; Rec."Full Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }

                field(Branch; Rec."Branch Name")
                {
                    ApplicationArea = All;
                }
                field(Department; Rec."Department Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                }
                field("Employment Date"; Rec."Employment Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Appraiser Employee No."; Rec."Appraiser Employee No.")
                {
                    Caption = 'Appraiser''s Employee No.';
                    ApplicationArea = All;
                }
                field("Appraiser Name"; Rec."Appraiser Name")
                {
                    Caption = 'Appraiser''s Name';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Appraiser Job Title"; Rec."Appraiser Job Title")
                {
                    Caption = 'Appraiser''s Title';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("JD Updated"; Rec."JD Updated")
                {
                    Caption = 'Job Description Updated';
                    ApplicationArea = All;
                }
            }
            part("Performance Assessment"; "Performance Competency Line-Qt")
            {
                Caption = 'Quantity Goals Performance Assessment';
                SubPageLink = "Review No." = field("Review No.");
                ApplicationArea = All;
            }
            part("Performance Assessment2"; "Performance Competency Line-Ql")
            {
                Caption = 'Quality Goals Performance Assessment';
                SubPageLink = "Review No." = field("Review No.");
                ApplicationArea = All;
            }
            group("Career and Development Needs")
            {
                Caption = 'Career and Development Needs';
                field("Career Plan Employee"; Rec."Career Plan Employee")
                {
                    Caption = 'Career Plan';
                    Editable = EditEmployeeComments;
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Career Plan"; Rec."Career Plan")
                {
                    Caption = 'Appraiser Comments';
                    MultiLine = true;
                    Visible = SeeAppraiserComments;
                    ApplicationArea = All;
                }
                field("Development Needs Employee"; Rec."Development Needs Employee")
                {
                    Caption = 'Development Needs';
                    Editable = EditEmployeeComments;
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Development Needs"; Rec."Development Needs")
                {
                    Caption = 'Appraiser Comments';
                    MultiLine = true;
                    Visible = SeeAppraiserComments;
                    ApplicationArea = All;
                }
            }
            group("Other Comments")
            {
                Caption = 'Other Comments';
                field("Employees Comments"; Rec."Employees Comments")
                {
                    Editable = EditEmployeeComments;
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Appraisers Comments"; Rec."Appraisers Comments")
                {
                    MultiLine = true;
                    Visible = SeeAppraiserComments;
                    ApplicationArea = All;
                }
            }
            group("Overall Rating")
            {
                Caption = 'Overall Rating';

                field("Score is Final"; Rec."Score is Final")
                {
                    ApplicationArea = All;
                }
                field("Total Score"; Rec."Total Score")
                {
                    ApplicationArea = All;
                }

                field("KPI Score"; Rec."KPI Score")
                {
                    Caption = 'KPI Achievement';
                    MultiLine = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("KPI Description"; Rec."KPI Description")
                {
                    Caption = 'KPI Achievement Description';
                    Editable = false;
                    Visible = false;
                    MultiLine = false;
                    ApplicationArea = All;
                }
                field("KPI Comments"; Rec."KPI Comments")
                {
                    Caption = 'Reviewer Recommendation';
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Overall Reviewer Recommend"; Rec."Overall Reviewer Recommend")
                {
                    Caption = 'Overall Reviewer Recommendation';
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Appraisal Agreement Reached"; Rec."Appraisal Agreement Reached")
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
            action("Forward to Appraiser")
            {
                Image = CoupledUsers;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = SeeForwardtoAppraiser;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    IF CONFIRM(Text000) THEN BEGIN
                        Rec.Testfield("Employee No.");
                        Rec.TestField("Appraiser Employee No.");
                        Rec."Released to Appraiser" := TRUE;
                        Rec.MODIFY();
                        MESSAGE(Text001);
                        CurrPage.CLOSE;
                    END;
                end;
            }
            action("Forward to HR")
            {
                Image = PersonInCharge;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = SeeForwardtoHR;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    IF CONFIRM(Text002) THEN BEGIN
                        Rec."Released to HR Admin" := TRUE;
                        Rec.MODIFY();
                        MESSAGE(Text003);
                        CurrPage.CLOSE;
                    END;
                end;
            }
        }
    }

    trigger OnOpenPage();
    begin
        SetVisibility;
    end;

    var
        SeeAppraiserComments: Boolean;
        UserSetup: Record 91;
        SeeForwardtoAppraiser: Boolean;
        SeeForwardtoHR: Boolean;
        EditEmployeeComments: Boolean;
        Text000: Label 'Are you sure you want to submit this review to your appraiser?';
        Text001: Label 'Submitted successfully!';
        Text002: Label 'Are you sure you want to forward this review to HR?';
        Text003: Label 'Forwarded successfully!';

    local procedure SetVisibility();
    begin
        IF UserSetup.GET(USERID) THEN BEGIN
            /*     IF UserSetup."Employee No." = "Employee No." THEN BEGIN
                     SeeAppraiserComments := FALSE;
                     EditEmployeeComments := TRUE;
                 END ELSE BEGIN
                     IF UserSetup."Employee No." = "Appraiser Employee No." THEN BEGIN
                         SeeAppraiserComments := TRUE;
                         EditEmployeeComments := FALSE;
                     END ELSE
                         SeeAppraiserComments := FALSE;
                     EditEmployeeComments := FALSE;
                 END;*/

            IF NOT Rec."Released to Appraiser" AND NOT Rec."Released to HR Admin" THEN BEGIN
                SeeForwardtoHR := FALSE;
                SeeForwardtoAppraiser := TRUE;
                EditEmployeeComments := TRUE;
                SeeAppraiserComments := FALSE;
            END;
            IF Rec."Released to Appraiser" AND NOT Rec."Released to HR Admin" THEN BEGIN
                SeeForwardtoAppraiser := FALSE;
                SeeForwardtoHR := TRUE;
                EditEmployeeComments := FALSE;
                SeeAppraiserComments := True;
            END;
            IF Rec."Released to HR Admin" THEN BEGIN
                SeeAppraiserComments := TRUE;
                EditEmployeeComments := FALSE;
                CurrPage.EDITABLE(FALSE);
            END;
        END;
    end;
}
