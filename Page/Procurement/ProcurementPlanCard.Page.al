page 50701 "Procurement Plan Card"
{
    // version TL2.0

    PageType = Card;
    SourceTable = "Procurement Plan Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = false;
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Editable = false;
                    Visible = true;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Current Budget"; Rec."Current Budget")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Budget Per Branch?"; Rec."Budget Per Branch?")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Budget Per Department?"; Rec."Budget Per Department?")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Created On"; Rec."Created On")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No. Of Approvals"; Rec."No. Of Approvals")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            part(page1; "Procurement Plan Lines")
            {
                SubPageLink = "Plan No" = FIELD("No.");
                ApplicationArea = All;
            }
        }
        area(factboxes)
        {
            part(page; "Procurement Plan FactBox")
            {
                SubPageLink = "No." = FIELD("No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Submit Procurement Plan")
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    ProcurementManagement.OnSubmitNewProcurementPlan(Rec);
                end;
            }
            action("Recall From Submission")
            {
                Visible = false;
            }
            action("Send Approval Request")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = SeeSendRequest;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    Rec.Status := Rec.Status::Approved;
                    Rec."CEO Approved" := true;
                    Rec.Modify();
                    Message('Procurement Plan has Been Approved');
                    /*ProcurementManagement.OnSubmitNewProcurementPlan(Rec);
                    IF ApprovalsMgmtExt.CheckProcurementPlanApprovalPossible(Rec) THEN BEGIN
                        ApprovalsMgmtExt.OnSendProcurementPlanForApproval(Rec);
                    END;
                     if ApprovalMgtTest.CheckProcurementPlanWorkflowEnabled(Rec) then begin
                        ApprovalMgtTest.OnSendProcurementPlanForApproval(Rec);
                    end; */
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
                Visible = SeeCancelReq;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    ApprovalsMgmtExt.OnCancelProcurementPlanApprovalRequest(Rec);
                    CurrPage.CLOSE;
                end;
            }
            action(Approve)
            {
                ApplicationArea = All;
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;
                ToolTip = 'Approve the requested changes.';
                Visible = SeeApprovals;

                trigger OnAction();
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalEntry.Reset();
                    ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                    ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
                    IF ApprovalEntry.FINDFIRST THEN
                        ApprovalsMgmt.ApproveApprovalRequests(ApprovalEntry);
                    CurrPage.CLOSE;

                end;
            }
            action(Reject)
            {
                ApplicationArea = All;
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Scope = Repeater;
                ToolTip = 'Reject the approval request.';
                Visible = SeeApprovals;

                trigger OnAction();
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalEntry.Reset();
                    ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                    ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
                    IF ApprovalEntry.FINDFIRST THEN
                        ApprovalsMgmt.RejectApprovalRequests(ApprovalEntry);
                    CurrPage.CLOSE;

                end;
            }
            action(Delegate)
            {
                ApplicationArea = All;
                Caption = 'Delegate';
                Image = Delegate;
                Promoted = true;
                PromotedCategory = Process;
                Scope = Repeater;
                ToolTip = 'Delegate the approval to a substitute approver.';
                Visible = SeeApprovals;

                trigger OnAction();
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalEntry.Reset();
                    ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                    ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
                    IF ApprovalEntry.FINDFIRST THEN
                        ApprovalsMgmt.DelegateApprovalRequests(ApprovalEntry);
                    CurrPage.CLOSE;

                end;
            }
            group("Release_")
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action(Release)
                {
                    ApplicationArea = All;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';
                    ToolTip = 'Release the document to the next stage of processing. When a document is released, it will be included in all availability calculations from the expected receipt date of the items. You must reopen the document before you can make changes to it.';

                    trigger OnAction();
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        //ReleasePurchDoc.PerformManualRelease(Rec);
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = All;
                    Caption = 'Re&open';
                    Image = ReOpen;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed';

                    trigger OnAction();
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        //ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }
            }

        }
    }

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        ValidateVisibility();
    end;

    trigger OnNextRecord(Steps: Integer): Integer;
    begin
        ValidateVisibility();
    end;

    trigger OnOpenPage();
    begin
        ValidateVisibility();
    end;

    var
        EditableOnOpen: Boolean;
        SeeBranch: Boolean;
        SeeDepartment: Boolean;
        ProcurementManagement: Codeunit "Procurement Management";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        //ApprovalsMgmtExt: Codeunit "Approvals Mgmt Ext";
        ApprovalEntry: Record "Approval Entry";
        SeeApprovals: Boolean;
        ApprovalsMgmtExt: Codeunit "Approvals Mgmt Proc";
        SeeSendRequest: Boolean;
        SeeCancelReq: Boolean;

    //ApprovalMgtTest: Codeunit ApprovalMgtTestExt;

    local procedure ValidateVisibility();
    begin
        SeeBranch := FALSE;
        SeeDepartment := FALSE;
        IF Rec."Budget Per Branch?" = TRUE THEN
            SeeBranch := TRUE;
        IF Rec."Budget Per Department?" = TRUE THEN
            SeeDepartment := TRUE;
        SeeSendRequest := TRUE;
        IF Rec.Status <> Rec.Status::New THEN BEGIN
            CurrPage.EDITABLE(FALSE);
            SeeSendRequest := FALSE;
        END;
        IF Rec.Status = Rec.Status::"Pending Approval" THEN begin
            IF Rec."Created By" = USERID THEN
                SeeCancelReq := TRUE
            ELSE
                SeeCancelReq := FALSE;
            SeeApprovals := true;
        end ELSE begin
            SeeCancelReq := FALSE;
        end;
    end;
}

