page 50160 "Cheque Clearance"
{
    // version CTS2.0

    Caption = 'Cheque Clearance';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval Request,Related Information,Posting,Category7';
    RefreshOnActivate = true;
    SourceTable = "Cheque Clearance Header";

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
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Approved Time"; Rec."Approved Time")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
            part("Cheque Clearance Subform"; "Cheque Clearance Subform")
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
            action(SendApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Request approval of the document.';
                Visible = IsVisibleSendApprovalRequest;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt Ext";
                begin

                    IF ApprovalsMgmt.CheckChequeClearanceApprovalPossible(Rec) THEN
                        ApprovalsMgmt.OnSendChequeClearanceForApproval(Rec);
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
                    ApprovalsMgmt.OnCancelChequeClearanceApprovalRequest(Rec);
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
                        CurrPage.CLOSE;
                    END;
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
                        CurrPage.CLOSE;
                    END;

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
                        CurrPage.CLOSE;
                    END;

                end;
            }


            action(Validate)
            {
                Image = ValidateEmailLoggingSetup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = IsValidateVisible;

                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::New);
                    IF CONFIRM(Text000, FALSE, Rec."No.") THEN BEGIN
                        IF NOT ChequeClearanceLine.LinesExist(Rec."No.") THEN
                            ERROR(Text006);

                        IF Rec.Status = Rec.Status::"Pending Approval" THEN
                            MESSAGE(Text001, Rec."No.")
                    END;
                end;
            }
            action(Post)
            {
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = IsPostVisible;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Approved);
                    IF CONFIRM(Text003, FALSE, Rec."No.") THEN BEGIN
                        COMMIT;
                        FOSAManagement.PostChequeClearance(Rec);
                    END;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        SetVisible;
        SetEditable;
    end;

    var
        IsValidateVisible: Boolean;
        IsPostVisible: Boolean;
        Text000: Label 'Do you want to validate PRM Entries for Document No. %1?';
        FOSAManagement: Codeunit "FOSA Management"
;
        Text001: Label 'PRM Entries for Document No. %1 have been validated successfully.';
        Text002: Label 'PRM Entries for Document No. have not been validated.';
        Text003: Label 'Do you want to Post PRM Entries for Document No. %1?';
        Text004: Label 'PRM Entries for Document No. %1 have been posted successfully.';
        Text005: Label 'PRM Entries for Document No. have not been posted.';
        IsVisibleSendApprovalRequest: Boolean;
        IsVisibleCancelApprovalRequest: Boolean;
        IsVisibleApprove: Boolean;
        IsVisibleReject: Boolean;
        IsVisibleDelegate: Boolean;

        ChequeClearanceLine: Record "Cheque Clearance Line";
        Text006: Label 'No lines exist.';

    local procedure SetVisible()
    begin
        CASE Rec.Status OF
            Rec.Status::New:
                BEGIN
                    IsValidateVisible := TRUE;
                    IsPostVisible := FALSE;
                    IsVisibleSendApprovalRequest := TRUE;
                    IsVisibleCancelApprovalRequest := FALSE;
                    IsVisibleApprove := false;
                    IsVisibleDelegate := false;
                    IsVisibleReject := false;
                END;
            Rec.Status::"Pending Approval":
                BEGIN
                    IsValidateVisible := FALSE;
                    IsPostVisible := false;
                    IsVisibleSendApprovalRequest := FALSE;
                    IsVisibleCancelApprovalRequest := TRUE;
                    IsVisibleApprove := true;
                    IsVisibleDelegate := true;
                    IsVisibleReject := true;
                END;
            Rec.Status::Approved:
                BEGIN
                    IsValidateVisible := FALSE;
                    IsPostVisible := TRUE;
                    IsVisibleSendApprovalRequest := FALSE;
                    IsVisibleCancelApprovalRequest := FALSE;
                    IsVisibleApprove := false;
                    IsVisibleDelegate := false;
                    IsVisibleReject := false;
                END;
            Rec.Status::Rejected:
                BEGIN
                    IsValidateVisible := FALSE;
                    IsPostVisible := FALSE;
                    IsVisibleSendApprovalRequest := FALSE;
                    IsVisibleCancelApprovalRequest := FALSE;
                END;
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
        IF Rec.Status = Rec.Status::Rejected THEN
            CurrPage.EDITABLE := FALSE;
        IF Rec.Posted THEN
            CurrPage.EDITABLE := FALSE;
    end;
}

