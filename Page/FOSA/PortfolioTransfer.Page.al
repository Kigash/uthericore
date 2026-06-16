page 55090 "Portfolio Transfer Card"
{
    // version MC2.0

    PageType = Card;
    SourceTable = "Portfolio Transfer";
    layout
    {
        area(content)
        {
            group(Source)
            {
                Caption = 'Source';
                Visible = NormalTransfer;


                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Transfer Type"; Rec."Transfer Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF Rec."Transfer Type" = 2 THEN
                            DestinationCaption := 'Handed Over To'
                        ELSE
                            DestinationCaption := 'Destination Loan Officer ID';
                        Visibility;
                    end;
                }
                group(TransferCategory)
                {
                    Caption = '';
                    field(Category; Rec.Category)
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            Visibility;
                        end;
                    }
                }
                field("Source Branch Code"; Rec."Source Branch Code")
                {
                    ApplicationArea = All;
                }
                field("Source Branch Name"; Rec."Source Branch Name")
                {
                    ApplicationArea = All;
                }
                field("Source Loan Officer ID"; Rec."Source Loan Officer ID")
                {
                    ApplicationArea = All;
                }
                group(TransferType2)
                {
                    Caption = '';
                    Visible = Rec."Transfer Type" <> 2;
                    field("Source Group No."; Rec."Source Group No.")
                    {
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            Visibility;
                        end;

                    }
                    field("Source Group Name"; Rec."Source Group Name")
                    {
                        ApplicationArea = All;
                    }
                }
                group(LOTransferType)
                {
                    Caption = '';
                    Visible = Rec."Transfer Type" = 2;
                    field(LoanOfficerGroups; Rec."No. of Groups")
                    {
                        Caption = 'No. of Groups';
                        ApplicationArea = All;
                    }
                    group(TransferType0)
                    {
                        Caption = '';
                        Visible = Rec."Transfer Type" = 0;
                        field("No. of Members"; Rec."No. of Members")
                        {
                            ApplicationArea = All;
                        }
                    }
                    field(LoanOfficerLoans; Rec."No. of Loans")
                    {
                        Caption = 'No. of Loans';
                        ApplicationArea = All;
                    }
                    field(LoanOfficerOutstandingAmount; Rec."Outstanding Loan Amount")
                    {
                        Caption = 'Outstanding Loan Amount';
                        ApplicationArea = All;
                    }
                }
                group(TransferType1)
                {
                    Caption = '';
                    Visible = Rec."Transfer Type" = 1;
                    field("Member No."; Rec."Member No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Member Name"; Rec."Member Name")
                    {
                        ApplicationArea = All;
                    }
                }
            }
            group(Destination)
            {
                Caption = 'Destination';
                Visible = NormalTransfer;
                group(GrpDestination)
                {
                    Caption = '';
                    Editable = Interbranch;
                    field("Destination Branch Code"; Rec."Destination Branch Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Destination Branch Name"; Rec."Destination Branch Name")
                    {
                        ApplicationArea = All;
                    }
                }
                group(DestinationLoanOfficer)
                {
                    Caption = '';
                    field(HandedOverTo; Rec."Destination Loan Officer ID")
                    {
                        CaptionClass = DestinationCaption;
                        Caption = 'Handed Over To';
                        ApplicationArea = All;
                    }
                }
                group(DestinationGroup)
                {
                    Caption = '';
                    Visible = Rec."Transfer Type" <> 0;
                    field("Destination Group No."; Rec."Destination Group No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Destination Group Name"; Rec."Destination Group Name")
                    {
                        ApplicationArea = All;
                    }
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group(Audit)
            {
                Editable = false;
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
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Approved Date"; Rec."Approved Date")
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
            action("Send Approval Request")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = SendApproval;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Rec.TestField("Source Branch Code");
                    Rec.TestField("Source Loan Officer ID");
                    Rec.TestField("Destination Branch Code");
                    Rec.TestField("Destination Loan Officer ID");
                    IF Rec."Transfer Type" <> Rec."Transfer Type"::"Loan Officer Transfer" THEN BEGIN
                        Rec.TestField("Source Group No.");
                    END;
                    IF Rec."Transfer Type" = Rec."Transfer Type"::"Client Transfer" THEN BEGIN
                        Rec.TestField("Member No.");
                        Rec.TestField("Destination Group No.");
                    END;

                    IF ApprovalsMgmt.CheckPortfolioTransferApprovalPossible(Rec) THEN
                        ApprovalsMgmt.OnSendPortfolioTransferForApproval(Rec);
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
                Visible = SendApproval;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    ApprovalsMgmt.OnCancelPortfolioTransferApprovalRequest(Rec);
                    CurrPage.CLOSE;
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
                Visible = IsVisibleApproveAction;


                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalEntry.RESET;
                    ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                    ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Open);
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
                Visible = IsVisibleRejectAction;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalEntry.RESET;
                    ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                    ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Open);
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
                Visible = IsVisibleDelegateAction;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalEntry.RESET;
                    ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                    ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Open);
                    IF ApprovalEntry.FINDFIRST THEN BEGIN
                        ApprovalsMgmt.DelegateApprovalRequests(ApprovalEntry);
                        CurrPage.CLOSE;
                    END;

                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.AttachmentFactBox.PAGE.SetParameter(Rec.RECORDID, Rec."No.");
        IF Rec."Transfer Type" = 2 THEN
            DestinationCaption := 'Handed Over To'
        ELSE
            DestinationCaption := 'Destination Loan Officer ID';
    end;

    trigger OnOpenPage()
    begin
        Visibility;
    end;

    var
        Interbranch: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt Ext";
        GroupTransfer: Boolean;
        ClientTransfer: Boolean;
        SendApproval: Boolean;
        CancelApproval: Boolean;
        LoanOfficerTransfer: Boolean;
        NormalTransfer: Boolean;
        IsVisibleApproveAction: Boolean;
        IsVisibleRejectAction: Boolean;
        IsVisibleDelegateAction: Boolean;
        DestinationCaption: Text[50];

    local procedure Visibility()
    begin
        IF Rec."Transfer Type" = Rec."Transfer Type"::"Loan Officer Transfer" THEN BEGIN
            LoanOfficerTransfer := TRUE;
            NormalTransfer := TRUE;
            GroupTransfer := FALSE;
            ClientTransfer := FALSE;
            Interbranch := FALSE;
        END;
        IF Rec."Transfer Type" = Rec."Transfer Type"::"Group Transfer" THEN BEGIN
            GroupTransfer := TRUE;
            ClientTransfer := FALSE;
            NormalTransfer := TRUE;
            LoanOfficerTransfer := FALSE;
        END;
        IF Rec."Transfer Type" = Rec."Transfer Type"::"Client Transfer" THEN BEGIN
            GroupTransfer := FALSE;
            ClientTransfer := TRUE;
            NormalTransfer := TRUE;
            LoanOfficerTransfer := FALSE;
        END;
        Interbranch := FALSE;
        IF Rec.Category = Rec.Category::"Inter-branch" THEN BEGIN
            Interbranch := TRUE;
        END;
        IF (Rec.Status = Rec.Status::Approved) OR (Rec.Status = Rec.Status::Rejected) THEN BEGIN
            SendApproval := FALSE;
            CancelApproval := FALSE;
            CurrPage.EDITABLE(FALSE);
        END;
        IF Rec.Status = Rec.Status::New THEN BEGIN
            SendApproval := TRUE;
            CancelApproval := TRUE;
        END;
        IF Rec.Status = Rec.Status::"Pending Approval" THEN BEGIN
            SendApproval := FALSE;
            CancelApproval := TRUE;
            CurrPage.EDITABLE(FALSE);
        END;
        IF Rec."Source Group No." <> '' THEN BEGIN
            GroupTransfer := TRUE;
        END ELSE
            GroupTransfer := FALSE;

        IF Rec.Status = Rec.Status::"Pending Approval" THEN BEGIN

            IsVisibleApproveAction := true;
            IsVisibleRejectAction := true;
            IsVisibleDelegateAction := true;

        END ELSE BEGIN
            IsVisibleApproveAction := FALSE;
            IsVisibleRejectAction := FALSE;
            IsVisibleDelegateAction := FALSE;
        END;

    end;
}

