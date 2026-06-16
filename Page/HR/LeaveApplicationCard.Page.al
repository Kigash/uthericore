page 50410 "Leave Application Card"
{
    // version TL2.0

    PageType = Card;
    SourceTable = 50206;

    layout
    {
        area(content)
        {
            group(Application)
            {
                field("Application No"; Rec."Application No")
                {
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Mobile No"; Rec."Mobile No")
                {
                    ApplicationArea = All;
                }
                field(Branch; Rec.Branch)
                {
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;
                }
                field("Leave Code"; Rec."Leave Code")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
            }
            group("Current Application")
            {
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("Days Applied"; Rec."Days Applied")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Resumption Date"; Rec."Resumption Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Duties Taken Over By"; Rec."Duties Taken Over By")
                {
                    ApplicationArea = All;
                }
                field("Substitute Name"; Rec."Substitute Name")
                {
                    ApplicationArea = All;
                }
                field("Leave balance"; Rec."Leave balance")
                {
                    ApplicationArea = All;
                }
                field("Reason for Leave"; Rec."Reason for Leave")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group(Balances)
            {
                field("Leave Earned to Date"; Rec."Leave Earned to Date")
                {
                    ApplicationArea = All;
                }
                field("Balance brought forward"; Rec."Balance brought forward")
                {
                    ApplicationArea = All;
                }
                field("Recalled Days"; Rec."Recalled Days")
                {
                    ApplicationArea = All;
                }
                field("Lost Days"; Rec."Lost Days")
                {
                    ApplicationArea = All;
                }
                field("Total Leave Days Taken"; Rec."Total Leave Days Taken")
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
            action(SendLeaveApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Request approval of the document.';
                Visible = ShowSendForApproval;

                trigger OnAction();
                var
                    ApprovalsMgmt: Codeunit 50054;
                begin
                    IF ApprovalsMgmt.CheckLeaveApplicationApprovalPossible(Rec) THEN BEGIN
                        ApprovalsMgmt.OnSendLeaveApplicationForApproval(Rec);
                    END;
                    CurrPage.CLOSE;
                end;
            }
            action(CancelLeaveApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel Approval Re&quest';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Cancel the approval request.';
                visible = ShowCancelApprovalRequest;

                trigger OnAction();
                var
                    ApprovalsMgmt: Codeunit 50054;
                    WorkflowWebhookMgt: Codeunit 1543;
                begin
                    ApprovalsMgmt.OnCancelLeaveApplicationApprovalRequest(Rec);
                    WorkflowWebhookMgt.FindAndCancel(Rec.RECORDID);
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
                Visible = ShowApprove;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    ApprovalEntry.RESET;
                    ApprovalEntry.SETRANGE("Document No.", Rec."Application No");
                    ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Open);
                    //  ApprovalEntry.SETRANGE("Approver ID", USERID);
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
                Visible = ShowReject;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    ApprovalEntry.RESET;
                    ApprovalEntry.SETRANGE("Document No.", Rec."Application No");
                    ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Open);
                    //   ApprovalEntry.SETRANGE("Approver ID", USERID);
                    IF ApprovalEntry.FINDFIRST THEN BEGIN
                        ApprovalsMgmt.RejectApprovalRequests(ApprovalEntry);
                    END ELSE BEGIN
                        ERROR(Error001);
                    END;
                end;
            }
            action("Print Leave Form")
            {
                Image = Form;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = false;

                trigger OnAction();
                begin
                    LeaveApplication.RESET;
                    LeaveApplication.SETFILTER("Application No", Rec."Application No");
                    IF LeaveApplication.FINDSET THEN BEGIN
                        REPORT.RUN(50070, TRUE, FALSE, LeaveApplication);
                    END;
                end;
            }
        }
    }

    trigger OnOpenPage();
    begin
        Visibility();
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        IF Rec.Status <> Rec.Status::New then begin
            Error('You cannot delete this record!');
        end;
    end;

    var
        ApprovalsMgmtExt: Codeunit 50054;
        ApprovalsMgmt: Codeunit 1535;

        ApprovalEntry: Record 454;
        //LeaveApplication1: Report 50070;
        LeaveApplication: Record 50206;

        Error000: Label 'There is no record to approve!';
        Error001: Label 'There is no record to reject!';
        ShowSendForApproval: Boolean;
        ShowCancelApprovalRequest: Boolean;
        ShowApprove: Boolean;
        ShowReject: Boolean;

    local procedure Visibility();
    begin
        IF Rec.Status = Rec.Status::New THEN BEGIN
            CurrPage.EDITABLE(TRUE);
            ShowSendForApproval := true;
            ShowCancelApprovalRequest := FALSE;
            ShowReject := FALSE;
            ShowApprove := FALSE;
        END;
        IF Rec.Status = Rec.Status::"Pending Approval" THEN BEGIN
            CurrPage.EDITABLE(FALSE);
            ShowSendForApproval := FALSE;
            ShowCancelApprovalRequest := FALSE;
            ShowReject := TRUE;
            ShowApprove := TRUE;
        END;
        IF (Rec.Status = Rec.Status::Rejected) OR (Rec.Status = Rec.Status::Released) THEN BEGIN
            CurrPage.Editable(false);
            ShowSendForApproval := FALSE;
            ShowCancelApprovalRequest := FALSE;
            ShowReject := FALSE;
            ShowApprove := FALSE;
        END;
    end;
}
