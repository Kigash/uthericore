page 50363 "Teller Close Till"
{
    Caption = 'Open/Close Till Card';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "Teller Close Till";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                }
                field("Action Type"; Rec."Action Type")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Till No."; Rec."Till No.")
                { }
                field("Till Name"; Rec."Till Name")
                { }
                field("Till Balance"; Rec."Till Balance")
                { }
                field(Status; Rec.Status)
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
            action(SendApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Request approval of the document.';
                Visible = IsVisibleSendApprovalRequest;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt Ext";
                begin
                    if Rec."Action Type" = Rec."Action Type"::" " then
                        Error('Kindly select the action type');
                    IF ApprovalsMgmt.CheckTellerCloseTillPossible(Rec) THEN begin
                        ApprovalsMgmt.OnSendTellerCloseTillForApproval(Rec);
                        CurrPage.Close();
                    end;
                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel Approval Re&quest';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Cancel the approval request.';
                Visible = IsVisibleCancelApprovalRequest;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt Ext";
                    WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                begin
                    ApprovalsMgmt.OnCancelTellerCloseTillApprovalRequest(Rec);
                end;
            }
            action(Approve)
            {
                ApplicationArea = Suite;
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Scope = Repeater;
                ToolTip = 'Approve the requested changes.';
                Visible = IsVisibleApprove;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalEntry.Reset();
                    ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                    ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
                    IF ApprovalEntry.FINDFIRST THEN BEGIN
                        ApprovalsMgmt.ApproveApprovalRequests(ApprovalEntry);
                    END;
                    CurrPage.CLOSE;
                end;
            }
            action(Reject)
            {
                ApplicationArea = Suite;
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Scope = Repeater;
                ToolTip = 'Reject the approval request.';
                Visible = IsVisibleReject;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalEntry.Reset();
                    ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                    ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
                    IF ApprovalEntry.FINDFIRST THEN BEGIN
                        ApprovalsMgmt.RejectApprovalRequests(ApprovalEntry);
                    END;
                    CurrPage.CLOSE;
                end;
            }
            action(Delegate)
            {
                ApplicationArea = Suite;
                Caption = 'Delegate';
                Image = Delegate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;
                ToolTip = 'Delegate the approval to a substitute approver.';
                Visible = IsVisibleDelegate;


                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalEntry.RESET;
                    ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                    ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
                    IF ApprovalEntry.FINDFIRST THEN BEGIN
                        ApprovalsMgmt.DelegateApprovalRequests(ApprovalEntry);
                    END;
                    CurrPage.CLOSE;
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        SetVisible;
        SetEditable;
    end;

    local procedure SetVisible()
    begin
        IF Rec.Status = Rec.Status::New THEN BEGIN
            IsVisibleSendApprovalRequest := TRUE;
            IsVisibleCancelApprovalRequest := FALSE;
            IsVisibleApprove := false;
            IsVisibleDelegate := false;
            IsVisibleReject := false;
            IsVisiblePost := false;
        END;
        IF Rec.Status = Rec.Status::"Pending Approval" THEN BEGIN
            IsVisibleSendApprovalRequest := FALSE;
            IsVisibleCancelApprovalRequest := TRUE;
            IsVisibleApprove := true;
            IsVisibleDelegate := true;
            IsVisibleReject := true;
            IsVisiblePost := false;
        END;
        IF Rec.Status = Rec.Status::Approved THEN BEGIN
            IsVisibleSendApprovalRequest := FALSE;
            IsVisibleCancelApprovalRequest := FALSE;
            IsVisibleApprove := false;
            IsVisibleDelegate := false;
            IsVisibleReject := false;
            IsVisiblePost := true;
        END;
        IF Rec.Status = Rec.Status::Rejected THEN BEGIN
            IsVisibleSendApprovalRequest := FALSE;
            IsVisibleCancelApprovalRequest := FALSE;
            IsVisibleApprove := false;
            IsVisibleDelegate := false;
            IsVisibleReject := false;
            IsVisiblePost := false;
        END;
    end;

    local procedure SetEditable()
    begin
        IF Rec.Status = Rec.Status::New THEN
            CurrPage.EDITABLE := TRUE;
        IF Rec.Status = Rec.Status::"Pending Approval" THEN
            CurrPage.EDITABLE := FALSE;
        IF Rec.Status = Rec.Status::Approved THEN
            CurrPage.EDITABLE := FALSE;
    end;

    var
        IsVisibleSendApprovalRequest: Boolean;
        IsVisibleCancelApprovalRequest: Boolean;
        IsVisibleApprove: Boolean;
        IsVisibleReject: Boolean;
        IsVisibleDelegate: Boolean;
        IsVisiblePost: Boolean;
        TelleringTreasury: Codeunit "Tellering & Treasury";
        PostConfirmMsg: Label 'Do you want to post this transaction?';
}