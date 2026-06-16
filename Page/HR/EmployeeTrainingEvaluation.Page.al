page 50497 "Employee Training Evaluation"
{
    // version TL2.0

    PageType = Card;
    SourceTable = 50275;

    layout
    {
        area(content)
        {
            group(General)
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
                    Caption = 'Branch';
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    Caption = 'Department';
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
            }
            part("Selective Questions"; 50517)
            {
                Caption = 'Selective Questions';
                SubPageLink = "Evaluation No." = field("No.");
                ApplicationArea = All;
            }
            part("Narrative Questions"; 50518)
            {
                Caption = 'Narrative Questions';
                SubPageLink = "Evaluation No." = field("No.");
                ApplicationArea = All;
            }



            group(Audit)
            {
                Caption = 'Audit';
                Editable = false;
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("Created Time"; Rec."Created Time")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Submitted Date"; Rec."Submitted Date")
                {
                    ApplicationArea = All;
                }
                field("Submitted Time"; Rec."Submitted Time")
                {
                    ApplicationArea = All;
                }
                field("Submitted By"; Rec."Submitted By")
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
            action("Submit Feedback")
            {
                Image = Completed;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = SeeSubmit;
                ApplicationArea = All;
                trigger OnAction();
                begin
                    IF CONFIRM(Text000) THEN BEGIN
                        Rec.Submitted := TRUE;
                        Rec."Submitted By" := USERID;
                        Rec."Submitted Date" := TODAY;
                        Rec."Submitted Time" := TIME;
                        Rec.MODIFY;
                        MESSAGE(Text001);
                    END;
                    CurrPage.CLOSE;
                end;
            }
        }
    }

    trigger OnOpenPage();
    begin
        Visibility;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        if Rec.Submitted then begin
            Error(Error000);
        end;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        if Rec.Submitted then begin
            Error(Error001);
        end;
    end;

    var
        Error000: Label 'This record cannot be deleted!';
        Error001: Label 'This record cannot be modified!';
        Text000: Label 'Are you sure you want to submit your feedback?';
        Text001: Label 'Your feedback has been submitted successfully!';
        SeeSubmit: Boolean;

    local procedure Visibility();
    begin
        IF Rec.Submitted THEN BEGIN
            SeeSubmit := FALSE;
            CurrPage.EDITABLE(FALSE);
        END ELSE BEGIN
            SeeSubmit := TRUE;
            CurrPage.EDITABLE(TRUE);
        END;
    end;
}
