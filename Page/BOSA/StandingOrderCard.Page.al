page 50181 "Standing Order Card"
{
    // version TL2.0

    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Standing Order";
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
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                }
                field("Source Account No."; Rec."Source Account No.")
                {
                    ApplicationArea = All;
                }
                field("Source Account Name"; Rec."Source Account Name")
                {
                    ApplicationArea = All;
                }
                field("Source Account Balance"; Rec."Source Account Balance")
                {
                    Importance = Additional;
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
                field(Frequency; Rec.Frequency)
                {
                    ApplicationArea = All;
                }
                field("Next Run Date"; Rec."Next Run Date")
                {
                    ApplicationArea = All;
                }
                field(Running; Rec.Running)
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Created Time"; Rec."Created Time")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Total Line Amount"; Rec."Total Line Amount")
                {
                    //Importance = Additional;
                    ApplicationArea = All;
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Approved By"; Rec."Approved By")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Approved Time"; Rec."Approved Time")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
            }
            part(Page; 50182)
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
            part(Page2; 50183)
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(processing)
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
                    IF ApprovalsMgmt.CheckStandingOrderApprovalPossible(Rec) THEN
                        ApprovalsMgmt.OnSendStandingOrderForApproval(Rec);
                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel Approval Re&quest';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Cancel the approval request.';
                Visible = IsVisibleCancelApprovalRequest;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt Ext";
                    WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                begin
                    ApprovalsMgmt.OnCancelStandingOrderApprovalRequest(Rec);
                    WorkflowWebhookMgt.FindAndCancel(Rec.RECORDID);
                end;
            }
            action(Post)
            {
                Caption = 'Activate Standing Order';
                Image = CashFlow;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = Rec.Status = 2;

                trigger OnAction()
                begin
                    BOSAManagement.PostStandingOrder(Rec);
                    Rec.Running := true;
                    Rec.Modify();
                    CurrPage.Update();
                    Message('Standing Order is activated');

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
                Visible = IsApproveVisible;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
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
                ApplicationArea = Suite;
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Scope = Repeater;
                ToolTip = 'Reject the approval request.';
                Visible = IsRejectVisible;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
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
                ApplicationArea = Suite;
                Caption = 'Delegate';
                Image = Delegate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;
                ToolTip = 'Delegate the approval to a substitute approver.';
                Visible = IsDelegateVisible;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
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
        }
    }

    trigger OnOpenPage()
    begin
        PageVisibility;
        PageEditable;
    end;

    var
        NoSeriesManagement: Codeunit "No. Series";Text000: Label 'A similar standing order already exist.';
        IsVisibleInternal: Boolean;
        IsVisibleExternal: Boolean;
        ApprovalEntry: Record "Approval Entry";
        IsVisibleCancelApprovalRequest: Boolean;
        IsVisibleSendApprovalRequest: Boolean;
        IsApproveVisible: Boolean;
        IsRejectVisible: Boolean;
        IsDelegateVisible: Boolean;
        IsPostVisible: Boolean;
        BOSAManagement: Codeunit "BOSA Management";

    local procedure PageVisibility()
    begin
        IF Rec.Status = Rec.Status::New THEN BEGIN
            IsVisibleCancelApprovalRequest := TRUE;
            IsVisibleSendApprovalRequest := TRUE;
        END ELSE BEGIN
            IsVisibleCancelApprovalRequest := FALSE;
            IsVisibleSendApprovalRequest := FALSE;
        END;

        IF Rec.Status = Rec.Status::"Pending Approval" THEN BEGIN
            IsApproveVisible := TRUE;
            IsRejectVisible := TRUE;
            IsDelegateVisible := TRUE;
        END;
    end;

    local procedure PageEditable()
    begin
        IF Rec.Status = Rec.Status::New THEN
            CurrPage.EDITABLE := TRUE
        ELSE
            CurrPage.EDITABLE := FALSE;
    end;
}

