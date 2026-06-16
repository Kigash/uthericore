page 55027 "Group Attendance"
{
    // version MC2.0

    PageType = Document;
    SourceTable = "Group Attendance Header";

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
                field("Group No."; Rec."Group No.")
                {
                    ApplicationArea = All;
                }
                field("Group Name"; Rec."Group Name")
                {
                    ApplicationArea = All;
                }
                field("Meeting Venue"; Rec."Meeting Venue")
                {
                    ApplicationArea = All;
                }
                field("Loan Officer ID"; Rec."Loan Officer ID")
                {
                    ApplicationArea = All;
                }
                field("Last Meeting Date"; Rec."Last Meeting Date")
                {
                    ApplicationArea = All;
                }
                field("Current Meeting Date"; Rec."Current Meeting Date")
                {
                    ApplicationArea = All;
                }
                field("Current Meeting Time"; Rec."Current Meeting Time")
                {
                    ApplicationArea = All;
                }
                field("Actual Meeting Date"; Rec."Actual Meeting Date")
                {
                    ApplicationArea = All;
                }
                field("Actual Meeting Time"; Rec."Actual Meeting Time")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
            part("Group Attendance List"; "Group Attendance Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
            }
            group(Audit)
            {
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("Created Time"; Rec."Created Time")
                {
                    ApplicationArea = All;
                }
                field("Validated By"; Rec."Validated By")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Validated Date"; Rec."Validated Date")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Validated Time"; Rec."Validated Time")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(AttachmentFactBox; "Attachement FactBox")
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Validate Attendance")
            {
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = IsVisibleValidateAttendance;

                trigger OnAction()
                begin
                    IF CONFIRM(Text000, TRUE, Rec."No.") THEN BEGIN
                        if MicroCreditManagement.ValidateGroupAttendance(Rec) then
                            MESSAGE(Text001, Rec."No.");
                    END;
                    CurrPage.CLOSE;
                end;
            }
            action(Print)
            {
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    Rec.RESET;
                    Rec.SETRANGE("No.", Rec."No.");
                    REPORT.RUN(52000, TRUE, FALSE, Rec);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.AttachmentFactBox.PAGE.SetParameter(Rec.RECORDID, Rec."No.");
    end;

    trigger OnOpenPage()
    begin
        PageVisibility;
        PageEditable;
    end;

    var
        Text000: Label 'Are you sure you want to validate attendance %1?';
        Member: Record Member;
        Text001: Label 'Attendance %1 has been validated successfully';
        MicroCreditManagement: Codeunit "MicroCredit Management";
        GroupAttendanceLine: Record "Group Attendance Line";
        IsVisibleValidateAttendance: Boolean;

    local procedure PageVisibility()
    begin
        IF Rec.Status = Rec.Status::New THEN
            IsVisibleValidateAttendance := TRUE
        ELSE
            IsVisibleValidateAttendance := FALSE;
    end;

    local procedure PageEditable()
    begin
        IF Rec.Status = Rec.Status::New THEN
            CurrPage.EDITABLE := TRUE
        ELSE
            CurrPage.EDITABLE := FALSE;
    end;
}

