page 50461 "Training Requests Card"
{
    // version TL2.0
    Caption = 'Training Request';
    PageType = Card;
    SourceTable = "Training Request";

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
                field("Training Description"; Rec."Training Description")
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
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = All;
                }
                field("Duration Units"; Rec."Duration Units")
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
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                }
                field("Cost of Training"; Rec."Cost of Training")
                {
                    ApplicationArea = All;
                }
                field("Reason for Request"; Rec."Reason for Request")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Total Cost of Training"; Rec."Total Cost of Training")
                {
                    ApplicationArea = All;
                }
            }
            part("Training Request Line"; "Training Request Lines")
            {
                SubPageLink = "Training Request No." = field("No.");
                ApplicationArea = All;
            }
            group("Audit Trail")
            {
                Editable = false;
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                }
                field("Request Time"; Rec."Request Time")
                {
                    ApplicationArea = All;
                }
                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Send Approval Request")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = ShowSendForApproval;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    IF CONFIRM(Text000) THEN BEGIN
                        IF ApprovalsMgmtExt.IsTrainingRequestApprovalsWorkflowEnabled(Rec) THEN
                            ApprovalsMgmtExt.OnSendTrainingRequestForApproval(Rec);
                    END;
                    CurrPage.CLOSE;
                end;
            }
            action("Cancel Approval Request")
            {
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = ShowCancelApprovalRequest;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    IF CONFIRM(Text002) THEN BEGIN
                        ApprovalsMgmtExt.OnCancelTrainingRequestApprovalRequest(Rec);
                    END;
                    CurrPage.CLOSE;
                end;
            }
            action(Approve)
            {
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                Visible = ShowApprove;

                trigger OnAction();
                begin
                    ApprovalEntry.RESET;
                    ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                    ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Open);
                    //    ApprovalEntry.SETRANGE("Approver ID", USERID);
                    IF ApprovalEntry.FINDFIRST THEN BEGIN
                        ApprovalsMgmt.ApproveApprovalRequests(ApprovalEntry);
                    END ELSE BEGIN
                        ERROR(Error000);
                    END;
                end;
            }
            action(Reject)
            {
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                Visible = ShowReject;

                trigger OnAction();
                begin
                    ApprovalEntry.RESET;
                    ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                    ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Open);
                    //  ApprovalEntry.SETRANGE("Approver ID", USERID);
                    IF ApprovalEntry.FINDFIRST THEN BEGIN
                        ApprovalsMgmt.RejectApprovalRequests(ApprovalEntry);
                    END ELSE BEGIN
                        ERROR(Error001);
                    END;
                end;
            }
            action("Add To Training Calendar")
            {
                Image = Add;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = SeeAddToCalendar;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    IF CONFIRM(Text004) THEN BEGIN
                        Rec."Added To Calendar" := TRUE;
                        Rec.MODIFY;
                        MESSAGE(Text006);
                    END;
                    CurrPage.CLOSE;
                end;
            }
            action("Submit To HR")
            {
                Image = CoupledOpportunity;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = SeeSubmitToHR;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    IF CONFIRM(Text005) THEN BEGIN
                        Rec."Submitted To HR" := TRUE;
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

    trigger OnAfterGetRecord()
    begin
        Visibility();
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        IF Rec.Status <> Rec.Status::New then begin
            Error('This record cannot be deleted!');
        end;
    end;

    var
        ApprovalsMgmt: Codeunit 1535;
        ApprovalsMgmtExt: Codeunit 50054;
        Text000: Label 'Are you sure you want to submit this training request for approval?';
        Text001: Label 'Training Request submitted successfuly!';
        Text002: Label 'Are you sure you want to cancel this training request?';
        Text003: Label 'Training Request cancelled successfuly!';
        ApprovalEntry: Record 454;
        Error000: Label 'There is no record to approve!';
        Error001: Label 'There is no record to reject!';
        ShowSendForApproval: Boolean;
        ShowCancelApprovalRequest: Boolean;
        ShowApprove: Boolean;
        ShowReject: Boolean;
        Text004: Label 'Are you sure you want to add this to the Training Calendar?';
        SeeAddToCalendar: Boolean;
        Text005: Label 'Are you sure you want to submit this training request to the HR for review?';
        SeeSubmitToHR: Boolean;
        Text006: Label 'Training Request Added Successfully!';

    local procedure Visibility();
    begin
        SeeSubmitToHR := FALSE;
        ShowSendForApproval := FALSE;
        ShowCancelApprovalRequest := FALSE;
        ShowReject := FALSE;
        ShowApprove := FALSE;
        SeeAddToCalendar := false;
        IF NOT Rec."Submitted To HR" THEN BEGIN
            SeeSubmitToHR := TRUE;
        END;
        IF (Rec.Status = Rec.Status::New) AND Rec."Submitted To HR" THEN BEGIN
            CurrPage.EDITABLE(TRUE);
            SeeAddToCalendar := TRUE;
        END;
        IF Rec.Status = Rec.Status::"Pending Approval" THEN BEGIN
            CurrPage.EDITABLE(FALSE);
            ShowReject := TRUE;
            ShowApprove := TRUE;
        END;
        IF (Rec.Status = Rec.Status::New) AND Rec."Added To Calendar" THEN BEGIN
            ShowSendForApproval := TRUE;
            SeeAddToCalendar := false
        END;
        IF Rec.Status <> Rec.Status::New then begin
            CurrPage.Editable(false);
        end;
    end;
}
